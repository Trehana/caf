class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  accepts_nested_attributes_for :tag
end
