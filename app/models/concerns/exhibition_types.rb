# Add Taggable to models
module ExhibitionTypes
  extend ActiveSupport::Concern

  included do
    has_many :exhibition_types, class_name: 'ExhibitionType', through: :taggings, source: :tag
  end

  attr_writer :attach_exhibition_types
  # ----------------------------#
  def attach_exhibition_types=(tags)
    attach_type_of_tags({ tags: tags, type: 'ExhibitionType' })
  end

  def drink_type_names
    exhibition_types.collect(&:name)
  end
end
