class AddAttributesToStocks < ActiveRecord::Migration[8.0]
  def change
    add_column :stocks, :name, :string
    add_column :stocks, :price, :decimal
    add_column :stocks, :exchange, :string
  end
end
