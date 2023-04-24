class AddProductRefToCategoryProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :category_products, :product, null: false, foreign_key: true
  end
end
