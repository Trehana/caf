class CoverPhoto < Asset
  has_attached_file :data,
                    url: "/assets/cover_photos/:hash.:extension",
                    hash_data: ":class/:attachment/:id/:style/:updated_at",
                    hash_secret: "lppernpidvyywzxuljqvbwcldganplmzythvizrcvkjlquejfdyewgsyowbojvhneeqopaijhnovhxgqnbevryojpqsmibszekwi",
                    styles: { :thumb => '120x120#' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
