class Restaurant < ActiveRecord::Base
has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy
belongs_to :user
validates_presence_of :user
validates :name, length: { minimum: 3 }, uniqueness: true
end
