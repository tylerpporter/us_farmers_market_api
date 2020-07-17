class CreateMarketProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :market_products do |t|
      t.references :product, foreign_key: true
      t.references :market, foreign_key: true
    end
  end
end
