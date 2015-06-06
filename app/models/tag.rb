class Tag < ActiveRecord::Base
  belongs_to :user    
  has_many :life_tags
  has_many :lives, through: :life_tags
end
