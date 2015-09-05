# Picture assets for pages, galleries that are not cover photos or profile photos
class Picture < Asset
  has_attached_file :data,
                    hash_data: ':class/:attachment/:id/:style/:updated_at',
                    path: '/pictures/:hash.:extension',
                    hash_secret: 'lppernpidvyywzxuljqvbwcldganplmzythvizrcvkjlquejfdyewgsyowbojvhneeqopaijhnovhxgqnbevryojpqsmibszekwi',
                    styles: { content: '800>', gallery_thumb: '540>', gallery_thumb_square: '540x540#', index_thumb: '540x340#', thumb: '100x100#' }

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  belongs_to :assetable, polymorphic: true

  scope :events_gallery, -> { where(assetable_type: 'Event').joins('INNER JOIN events on assetable_id = events.id').where(events: { state: 'published' }).order(updated_at: 'DESC').limit(200).sample(8) }

  def url_content
    url(:content)
  end
end
