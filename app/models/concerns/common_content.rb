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
      validates_presence_of :title, message: I18n.t('common.state.slug_blank')
    end

    scope :published_content, -> { where.not(state: %w(deleted draft hidden)) }
    scope :editors_content, -> { where.not(state: %w(deleted hidden)) }
  end

  # Class Methods
  module ClassMethods
  end
end
