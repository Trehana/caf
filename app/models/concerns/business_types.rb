# Add Taggable to models
module BusinessTypes
  extend ActiveSupport::Concern

  included do
    has_many :business_types, class_name: 'BusinessType', through: :taggings, source: :tag
  end

  attr_writer :attach_business_types
  # ----------------------------#
  def attach_business_types=(tags)
    attach_type_of_tags({ tags: tags, type: 'BusinessType' })
  end

  def business_type_names
    business_types.collect(&:name)
  end
end
