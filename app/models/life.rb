class Life < ActiveRecord::Base
  belongs_to :user
  has_many :life_tags
  has_many :tags, through: :life_tags

  before_save :with_spend_time
  after_commit :process_tags


  def with_spend_time
    self.spend_time = self.end_time.to_time - self.start_time.to_time
  end

  def process_tags
    tags_array = self.tags_all.split

    tags_array.each do |tag|
      self.user.tags.create(name: tag) if !self.user.tags.exists?(name: tag)
      this_tag = self.user.tags.find_by(name: tag)
      self.tags << this_tag
    end
  end

end
