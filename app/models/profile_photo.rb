# Profile photo for Profils
class ProfilePhoto < Asset
  has_attached_file :data,
                    url: '/images/profile_photos/:hash.:extension',
                    hash_data: ':class/:attachment/:id/:style/:updated_at',
                    hash_secret: 'lppernpidvyywzxuljqvbwcldganplmzythvizrcvkjlquejfdyewgsyowbojvhneeqopaijhnovhxgqnbevryojpqsmibszekwi',
                    styles: { standard: '200x200#', thumb: '102x102#' }

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end
