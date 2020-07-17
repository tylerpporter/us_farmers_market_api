class ChangeColumnNamesMarket < ActiveRecord::Migration[5.2]
  def change
    rename_column :markets, :FMID, :fmid
    rename_column :markets, :market_name, :marketname
    rename_column :markets, :season_1_date, :season1date
    rename_column :markets, :seson_1_time, :season1time
    rename_column :markets, :season_2_date, :season2date
    rename_column :markets, :season_2_time, :season2time 
  end
end
