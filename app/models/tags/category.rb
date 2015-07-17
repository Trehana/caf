# Category tag
class Category < Tag
  has_many :events, through: :taggings, source: :taggable, source_type: Event
  has_many :articles, through: :taggings, source: :taggable, source_type: Article
end
