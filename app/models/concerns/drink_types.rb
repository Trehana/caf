# Add Taggable to models
module DrinkTypes
  extend ActiveSupport::Concern
  include Taggable

  included do
    has_many :drink_types, class_name: 'DrinkType', through: :taggings, source: :tag
  end

  attr_writer :attach_drink_types
  # ----------------------------#
  def attach_drink_types=(tags)
    attach_type_of_tags(tags: tags, type: 'DrinkType')
  end

  def drink_type_names
    drink_types.collect(&:name)
  end
end
