class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :restaurants
  has_many :reviewed_restaurants, through: :reviews, source: :restaurant
  has_many :reviews

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{auth.uid}@facebook.com"
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def has_reviewed?(restaurant)
    reviewed_restaurant.include?(restaurant)
  end
end
