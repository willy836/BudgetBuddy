class Category < ApplicationRecord
    belongs_to :user
    has_many :category_products
    has_many :products, through: :category_products
    has_one_attached :image

    validates :name, presence: true
end
