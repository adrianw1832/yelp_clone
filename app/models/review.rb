class Review < ActiveRecord::Base
  include AsUserAssociationExtension

  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements

  validates :user, uniqueness: { scope: :restaurant }
end
