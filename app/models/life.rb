class Life < ActiveRecord::Base
  belongs_to :user
  has_many :life_tags
  has_many :tags, through: :life_tags
  has_many :life_companions
  has_many :companions, through: :life_companions

  before_save :with_spend_time
  after_commit :process_tags
  after_commit :process_locations
  after_commit :process_companions
  default_scope { order(:start_time) }


  def with_spend_time
    self.spend_time = self.end_time.to_time - self.start_time.to_time if end_time.present? &&  start_time.present?
  end

  def process_tags
    tags_array = self.tags_all.split

    self.tags.delete_all
    tags_array.each do |tag|
      self.user.tags.create(name: tag) if !self.user.tags.exists?(name: tag)
      this_tag = self.user.tags.find_by(name: tag)
      self.tags << this_tag
    end
  end

  def process_locations
    name = self.location.strip
    if !self.user.locations.exists?(name: name)
      self.user.locations.create(name: name) 
    else
      self.user.locations.find_by(name: name).increment!(:count)
    end if self.location.present?
  end

  def process_companions
    companions_array = self.companion.split
    companions_array.each do |name|
      self.user.companions.create(name: name) if !self.user.companions.exists?(name: name)
      this_companion = self.user.companions.find_by(name: name)
      self.companions << this_companion
    end
  end

end
