# Add Taggable to models
module Categories
  extend ActiveSupport::Concern

  included do
    has_many :categories, class_name: 'Category', through: :taggings, source: :tag
  end

  attr_writer :attach_categories
  # ----------------------------#
  def attach_categories=(tags)
    attach_type_of_tags({ tags: tags, type: 'Category' })
  end

  def category_names
    categories.collect(&:name)
  end
end
