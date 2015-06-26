# News Article
class Article < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy
end
