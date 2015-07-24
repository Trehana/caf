# Common methods and validations for models
module CommonContent
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    state_machine initial: :hidden do
      event :publish do
        transition draft: :published
        transition hidden: :published
      end

      event :save_draft do
        transition hidden: :draft
        transition published: :draft
      end

      event :move_to_trash do
        transition hidden: :deleted
        transition draft: :deleted
        transition published: :deleted
      end

      state :published, :draft do
        validate :validate_model
      end
    end

    def validate_model
      errors[:base] << I18n.t('common.state.slug_blank', attribute: I18n.t("helpers.label.#{self.class.name.parameterize}.title")) if title.blank?
    end

    scope :published_content, -> { where(state: 'published') }
    scope :editors_content, -> { where.not(state: %w(deleted hidden)) }
  end

  private

  def array_to_params(array)
    array.map(&:parameterize)
  end

  def array_to_param_hash(array, invert = false, keys_only = false)
    hash = {}
    array.map { |tag| hash[tag.parameterize] = tag }
    hash = invert ? hash.invert : hash
    keys_only ? hash.keys : hash
  end

  # Class Methods
  module ClassMethods
  end
end
