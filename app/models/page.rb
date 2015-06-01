class Page < ActiveRecord::Base
  include CommonContent
  has_one :cover_photo, :class_name => "Asset", :as => :assetable, :dependent => :destroy
  has_many :pictures, :class_name => "Asset", :as => :assetable, :dependent => :destroy
end
