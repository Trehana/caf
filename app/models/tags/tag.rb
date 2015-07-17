# Tags
class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :taggings

  def to_s
    name
  end

  def name=(val)
    write_attribute(:name, val.downcase)
  end
end
