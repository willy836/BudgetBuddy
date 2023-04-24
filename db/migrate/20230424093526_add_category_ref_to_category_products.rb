class AddCategoryRefToCategoryProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :category_products, :category, null: false, foreign_key: true
  end
end
