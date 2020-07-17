class AddColumnsToMarket < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :FMID, :integer
    add_column :markets, :market_name, :string
    add_column :markets, :website, :string
    add_column :markets, :street, :string
    add_column :markets, :city, :string
    add_column :markets, :state, :string
    add_column :markets, :zip, :string
    add_column :markets, :season_1_date, :string
    add_column :markets, :seson_1_time, :string
    add_column :markets, :season_2_date, :string
    add_column :markets, :season_2_time, :string
    add_column :markets, :lat, :string
    add_column :markets, :lng, :string
  end
end
