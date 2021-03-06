# Standard attachment that's not an image
class AttachmentFile < Asset
  has_attached_file :data,
                    # url: '/assets/attachments/:id/:filename',
                    path: '/attachments/:id/:filename'

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 100.megabytes
  do_not_validate_attachment_file_type :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
