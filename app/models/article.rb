# News Article
class Article < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include Taggable
  include Categories

  searchkick callbacks: :async
  def search_data
    {
      title: title,
      categories: category_names,
      date: updated_at
    }
  end

  paginates_per 9

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  scope :coffee_news, -> { published_content.joins(:categories).where(tags: { name: 'coffee' }) }
  scope :art_news, -> { published_content.joins(:categories).where(tags: { name: 'art' }) }

  def self.allowed_categories
    %w(coffee art)
  end
end
