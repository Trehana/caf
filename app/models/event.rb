# Events
class Event < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include Taggable
  include DefaultAddress

  has_one :cover_photo, as: :assetable, dependent: :destroy
  has_many :pictures, as: :assetable, dependent: :destroy

  searchkick callbacks: :async
  def search_data
    attributes.merge(
      tag_names: tag_names
    )
  end

  paginates_per 9

  #
  scope :between, ->(start_time, end_time) { published_content.where('starts_at BETWEEN ? AND ?', Date.parse(start_time), Date.parse(end_time)) }

  def as_json(options = {})
    {
      title: title,
      start: starts_at.strftime('%Y-%m-%d'),
      end: ends_at.strftime('%Y-%m-%d'),
      url: Rails.application.routes.url_helpers.event_path(slug),
      className: tags.to_a.join(' ')
    }
  end

  def validate_model
    validates_presence_of :title, message: I18n.t('common.state.slug_blank')
    validates_presence_of :starts_at, :ends_at
  end

  def opens_at
    return nil unless super
    super.utc.strftime('%I:%M%p')
  end

  def closes_at
    return nil unless super
    super.utc.strftime('%I:%M%p')
  end

  def self.allowed_tags
    %w(coffee art sponsored)
  end
end
