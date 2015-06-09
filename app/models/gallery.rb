# Photo gallery
class Gallery < ActiveRecord::Base
  include CommonContent
  has_many :pictures, as: :assetable, dependent: :destroy
end
