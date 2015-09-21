class Banner < ActiveRecord::Base
  state_machine initial: :hidden do
      event :publish do
        transition draft: :published
        transition hidden: :published
        transition  published: :published
      end

      event :save_draft do
        transition draft: :draft
        transition hidden: :draft
        transition published: :draft
      end
  end  
end
