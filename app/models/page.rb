# Generic pages
class Page < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include Taxonable
  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy
end
