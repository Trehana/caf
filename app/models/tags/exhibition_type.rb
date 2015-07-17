class ExhibitionType < Tag
  has_many :art_galleries, through: :taggings, source: :taggable, source_type: ArtGallery
end
