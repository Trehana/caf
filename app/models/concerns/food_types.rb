# Add Taggable to models
module FoodTypes
  extend ActiveSupport::Concern

  included do
    has_many :food_types, through: :taggings, source: :tag
  end

  attr_writer :attach_food_types
  # ----------------------------#
  def attach_food_types=(tags)
    attach_type_of_tags({ tags: tags, type: 'FoodType' })
  end

  def food_type_names
    food_types.collect(&:name)
  end
end
