# Add Taggable to models
module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end

  def tag(name)
    name.strip!
    tag = Tag.where(name: name.capitalize).first_or_create
    taggings.where(tag_id: tag.id).first_or_create
  end

  def tag_names
    tags.collect(&:name)
  end
end
