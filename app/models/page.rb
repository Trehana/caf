class Page < ActiveRecord::Base
  include CommonContent
  # has_one :cover_photo, class_name: "Asset", :as => :assetable, :dependent => :destroy
  # has_many :pictures, class_name: "Asset", :as => :assetable, :dependent => :destroy
  has_one :cover_photo, :as => :assetable, :dependent => :destroy
  has_many :pictures, :as => :assetable, :dependent => :destroy

end
