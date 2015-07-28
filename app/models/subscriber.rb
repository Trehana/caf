class Subscriber
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, presence: true

  def initialize(email)
    @email = email
    @gibbon = Gibbon::API.new(Settings.gibbon[:api_key])
  end

  def subscribe
    @gibbon.lists.subscribe(
      id: Settings.gibbon[:list_id],
      email: { email: email }
    )
    return self
  rescue Gibbon::MailChimpError => e
    errors.add(:base, e.message)
    return self
  end

  def self.subscribe(email)
    new(email).subscribe
  end
end
