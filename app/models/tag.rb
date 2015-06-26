class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :taggings
  has_many :articles, through: :taggings, source: :taggable, source_type: Article
end
