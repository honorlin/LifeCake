require 'capistrano/rails/assets'
# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'lifecake'
set :repo_url, 'git@github.com:honorlin/LifeCake.git'
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/lifecake'

#set :log_level, :debug  

set :tmp_dir, "/home/deploy/lifecake/shared/tmp"  

#set :rvm_type, :system
#set :rvm_ruby_version, '2.2.2'

#set :rvm_custom_path, '/usr/local/rvm/gems/ruby-2.2.2/bin'  # only needed if not detected
#set :ssh_options, { :forward_agent => true }

# Default value for :scm is :git
# set :scm, :git
[]
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp shared vendor/bundle public/system public/uploads public/assets public/images}

set :bundle_bins, fetch(:bundle_bins, []).push('my_new_binary')
set :bundle_binstubs, -> { shared_path.join('bin') }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"



set :keep_releases, 20


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      #release_path.join('tmp/restart.txt')
      puts "***** 重新啟動Rails Server! *****"
      execute "touch #{ current_path }/tmp/restart.txt"
    end
  end

  #after :publishing, :restart

  #after :finishing, 'deploy:restart'
  after :publishing, 'deploy:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
  # after 'deploy:restart', 'unicorn:restart'   # app preloaded
  # after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)

  #after 'deploy:publishing', 'deploy:restart'
end
