class User < ApplicationRecord
  has_many :products
  has_many :categories

  validates :name, presence: true
end
