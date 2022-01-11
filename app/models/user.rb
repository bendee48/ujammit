class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise    :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
  validates :email, presence: true
  encrypts  :access_token, :refresh_token

  def access_valid?
    access_token_expiration > DateTime.now if access_token.present?
  end
end
