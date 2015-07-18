# Tags
class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :taggings

  def to_s
    name
  end
end
