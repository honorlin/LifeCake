class Companion < ActiveRecord::Base
  belongs_to :user
  has_many :life_companions
  has_many :lives, through: :life_companions
end
