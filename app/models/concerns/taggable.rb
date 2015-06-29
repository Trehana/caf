# Add Taggable to models
module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
    accepts_nested_attributes_for :taggings

    attr_accessor :set_tags
  end

  def tag(name)
    name.strip!
    return unless self.class.try('allowed_tags') && self.class.allowed_tags.index(name)
    tag = Tag.where(name: name.downcase).first_or_create
    taggings.where(tag_id: tag.id).first_or_create
  end

  def tag_names
    tags.collect(&:name)
  end

  def set_tags=(new_tags)
    @set_tags = new_tags
  end

  def before_save
    tags.collect { |tag| tags.delete(tag) unless new_tags.index(tag.name) }
    set_tags.collect { |tag_name| tag(tag_name) }
  end
end
