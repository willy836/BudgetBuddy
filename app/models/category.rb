class Category < ApplicationRecord
    belongs_to :user
    has_many :category_products
    has_many :products, through: :category_products
    has_one_attached :image

    validates :name, presence: true

    def total_amount
        products.sum(:amount)
    end

    def recent_products
        products.order(created_at: :desc)
    end
end
