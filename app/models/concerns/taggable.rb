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

  def tag(allowed_tags_hash, tag_param, tag_type_class)
    tag_param.strip!
    return unless allowed_tags_hash.key?(tag_param.parameterize)
    tag = Object.const_get(tag_type_class).find_or_create_by(name: allowed_tags_hash[tag_param])
    taggings.find_or_create_by(tag_id: tag.id)
  end

  def attach_type_of_tags(value)
    return unless value.is_a?(Hash) && [:tags, :type].all? { |k| value.key? k } && allowed_types.include?(value[:type])
    existing_tags = send(value[:type].underscore.pluralize)
    existing_tags.each do |tag|
      unless value[:tags].include?(tag.slug)
        tagging = Tagging.find_by(tag_id: tag.id, taggable_id: id, taggable_type: self.class.name)
        tag.taggings.delete(tagging)
        tagging.destroy
        # tag.destroy if tag.taggings.count == 0
      end
    end
    #
    allowed_tags = 'allowed_' + value[:type].underscore.pluralize
    return unless allowed_tags_array = self.class.try(allowed_tags)
    allowed_tags_hash = array_to_param_hash(allowed_tags_array)
    #
    value[:tags].each do |tag_param|
      tag(allowed_tags_hash, tag_param, value[:type])
    end
    #
    # Need to reload the associations again to ensure this works better. Otherwise the objects may not get refreshed properly
    send(value[:type].underscore.pluralize).reload
  end

  # Specify which tag types are allowed
  def allowed_types
    %w(BusinessType Category DrinkType ExhibitionType FoodType)
  end
end
