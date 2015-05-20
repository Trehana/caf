class Page < ActiveRecord::Base
  state_machine initial: :hidden do
    event :publish do
      transition draft: :published
      transition hidden: :published
    end

    event :save_draft do
      transition hidden: :draft
      transition published: :draft
    end
  end
end
