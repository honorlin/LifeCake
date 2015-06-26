module SelectItems
  extend ActiveSupport::Concern

  included do
    before_action :find_select_items
  end

  def find_select_items
    @tags = current_user.tags
    @locations = current_user.locations
    @companions = current_user.companions
  end


end