class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  def self.from_auth(auth)
    user = find_or_initialize_by(email: auth.info.email)

    if user.new_record?
      user.password = Devise.friendly_token[0, 20]
      user.confirmation_at = Time.current
    end

    user.name ||= auth.info.name
    user.remote_image_url = auth.info.image if auth.info.image.present?
    user.facebook_uid = auth.uid

    user.save!
  end
end
