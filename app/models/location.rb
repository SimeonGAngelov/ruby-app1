class Location < ApplicationRecord
  belongs_to :user
  has_many :hourly_weathers, dependent: :destroy

  validates :latitude, :longitude, presence: true
  validates :latitude, uniqueness: { scope: [ :user_id, :longitude ] }
end
