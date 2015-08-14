# Add DeleteProtection to models
module DeleteProtection
  extend ActiveSupport::Concern

  included do
    before_destroy :check_delete_protection
  end

  def check_delete_protection
    return true unless delete_protection == 1
    errors.add :base, I18n.t('authorization.protected_record')
    false
  end
end
