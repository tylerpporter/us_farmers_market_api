require 'rails_helper'
require './db/csv/model_manager.rb'

describe 'model_manager' do
  it 'should generate markets' do
    ModelManager.destroy_and_create_markets('./spec/fixtures/markets.csv')

    expect(Market.all.size).to eq(50)
    expect(Product.all.size).to eq(30)
    expect(Market.all.sample.products).not_to be_empty
  end
end
