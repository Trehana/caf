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
        validates_presence_of :title, message: I18n.t('common.state.title_blank')
      end
    end
  end

  module ClassMethods
    def published_content
      where.not(state: ['deleted', 'draft'])
    end

    def editors_content
      where.not(state: 'deleted')
    end
  end
end
