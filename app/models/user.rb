# Devise user model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # :registerable # being removed for the time being.
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Use active job to send mails through a queu instead of direct sending
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
