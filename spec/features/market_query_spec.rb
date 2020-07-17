require 'rails_helper'
require './db/csv/model_manager.rb'

describe "Market Queries" do 
    it "can return all markets" do
        ModelManager.destroy_and_create_markets(File.open('./spec/fixtures/markets.csv'))
        expect(Market.count).to eq(50)
        post('/', params: { query: 'query { allMarkets { id marketname products { id name } }}'})
        markets = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(markets[:data][:allMarkets].size).to eq(50)
        market = markets[:data][:allMarkets][0]
        expect(market).to have_key(:id)
        expect(market).to have_key(:marketname)
        expect(market).to have_key(:products)
        expect(market[:products].count).to eql(21)
    end

    it "can return a single market" do
        ActiveRecord::Base.connection.tables.each do |t|
          ActiveRecord::Base.connection.reset_pk_sequence!(t)
        end
         ModelManager.destroy_and_create_markets(File.open('./spec/fixtures/markets.csv'))
        expect(Market.count).to eq(50)
        post('/', params: { query: 'query { market(id: 1) { id marketname products { id name } }}'})
        market = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        market = market[:data][:market]
        expect(market).to have_key(:id)
        expect(market).to have_key(:marketname)
        expect(market).to have_key(:products)
        expect(market[:products].count).to eql(21)
    end
end     

