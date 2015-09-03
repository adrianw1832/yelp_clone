class Restaurant < ActiveRecord::Base
  include AsUserAssociationExtension

  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy
  belongs_to :user
  validates_presence_of :user
  validates :name, length: { minimum: 3 }, uniqueness: true
end
