class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :social_profiles

  def self.from_auth(auth)
    find_or_initialize_by(email: auth.info.email).tap do |user|
      if user.new_record?
        user.password = Devise.friendly_token[0, 20]
        user.confirmed_at = Time.current
      end

      user.social_profiles.find_or_initialize_by(provider: :facebook, uid: auth.uid)

      user.save!
    end
  end
end
