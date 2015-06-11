# Profiles
class Profile < ActiveRecord::Base
  include CommonContent
  has_one :profile_photo, as: :assetable, dependent: :destroy
end
