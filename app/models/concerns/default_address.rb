# Add Address to models
module DefaultAddress
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address

    validate do |record|
      if address
        address.errors.full_messages.each do |msg|
          errors[:base] << msg
        end
        validate_model
      end
    end

  end
end
