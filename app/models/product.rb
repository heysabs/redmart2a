class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates :name, presence: true, length: { maximum: 50 }
  validates :price, presence: true

end
