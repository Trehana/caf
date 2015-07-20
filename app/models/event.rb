# Events
class Event < ActiveRecord::Base
  include CommonContent
  include DefaultImage
  include DefaultAddress
  include Taggable
  include Categories


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
  scope :between, ->(start_time, end_time) { published_content.where('starts_at BETWEEN ? AND ?', Date.parse(start_time), Date.parse(end_time)).order(starts_at: 'ASC') }
  scope :events_gallery, -> { joins(:pictures).order(updated_at: 'DESC').limit(8) }

  def as_json(options = {})
    {
      title: title,
      start: starts_at.strftime('%Y-%m-%d'),
      end: ends_at.strftime('%Y-%m-%d'),
      url: Rails.application.routes.url_helpers.event_path(slug),
      className: category_names,
      image_url: default_thumb,
      event_date: starts_at.day.ordinalize,
      address: address.to_s
    }
  end

  def simplify
    {
      title: title,
      date: (starts_at == ends_at ? starts_at.strftime('%Y-%m-%d') : "#{starts_at.strftime('%Y-%m-%d')} - #{ends_at.strftime('%Y-%m-%d')}"),
      time: "#{opens_at} - #{closes_at}",
      address: address.to_s,
      email: email,
      facebook: (facebook unless facebook.blank?),
      twitter: (twitter unless twitter.blank?),
      instagram: (instagram unless instagram.blank?),
      pinterest: (pinterest unless pinterest.blank?),
      organizer: organizer,
      description: description
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

  def self.allowed_categories
    %w(coffee art sponsored)
  end

  def self.allowed_social_media_names
    %w(facebook twitter instagram pinterest)
  end
end
