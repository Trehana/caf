# Add Taggable to models
module CafeTypes
  extend ActiveSupport::Concern

  included do
    has_many :cafe_types, through: :taggings, source: :tag
  end

  attr_writer :attach_cafe_types
  # ----------------------------#
  def attach_cafe_types=(tags)
    attach_type_of_tags({ tags: tags, type: 'CafeType' })
  end

  def cafe_type_names
    cafe_types.collect(&:name)
  end
end
