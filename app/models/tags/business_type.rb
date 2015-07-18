class BusinessType < Tag
  has_many :cafes, through: :taggings, source: :taggable, source_type: Cafe
end
