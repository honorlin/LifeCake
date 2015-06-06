class Life < ActiveRecord::Base
  belongs_to :user

  before_save :with_spend_time
  before_save :process_tags

  def with_spend_time
    self.spend_time = self.start_time.to_time - self.end_time.to_time
  end

  def process_tags
    tags_array = self.tags.split

  end

end
