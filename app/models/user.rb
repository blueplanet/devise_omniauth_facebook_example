class User < ActiveRecord::Base
  include DeviseSocialLogin::UserFromAuth

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable

end
