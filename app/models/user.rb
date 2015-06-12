# Devise user model
class User < ActiveRecord::Base
  # Keep this order as it is to avoid mixing up of user roles, since
  # user roles are stored in the table as integers.
  enum role: [:super_admin, :admin, :editor, :user]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def role?
    role
  end

  def ability
    @ability ||= AdminAbility.new(self)
  end
  #
  delegate :can?, :cannot?, to: :ability

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  # :registerable # being removed for the time being.
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Use active job to send mails through a queu instead of direct sending
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
