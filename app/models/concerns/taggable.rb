# Add Taggable to models
module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
    accepts_nested_attributes_for :taggings
  end

  # attr_accessor :make_tags
  # attr_writer :make_tags

  def tag_names
    tags.collect(&:name)
  end

  #
  private

  def tag(name, tag_type_class)
    name.strip!
    tag_type_class.strip!
    allowed_tags = 'allowed_' + tag_type_class.underscore.pluralize
    return unless self.class.try(allowed_tags) && self.class.send(allowed_tags).include?(name)
    tag = Object.const_get(tag_type_class).where(name: name.downcase).first_or_create
    taggings.where(tag_id: tag.id).first_or_create
  end

  def attach_type_of_tags(value)
    return unless value.is_a?(Hash) && [:tags, :type].all? { |k| value.key? k } && allowed_types.include?(value[:type])
    existing_tags = send(value[:type].underscore.pluralize)
    existing_tags.collect { |tag| tags.delete(tag) unless value[:tags].include?(tag.name) }
    value[:tags].collect { |tag_name| tag(tag_name, value[:type]) }
  end

  # Specify which tag types are allowed
  def allowed_types
    %w(CafeType Category DrinkType ExhibitionType FoodType)
  end
end
