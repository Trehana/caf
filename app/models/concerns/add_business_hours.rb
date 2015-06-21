# Common methods and validations for models
module AddBusinessHours
  extend ActiveSupport::Concern

  included do
    serialize :business_hours, BusinessHours
  end

  # Class Methods
  module ClassMethods

  end
end
