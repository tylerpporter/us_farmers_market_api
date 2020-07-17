require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "relationships" do
    it { should have_many :market_products }
    it { should have_many(:markets).through(:market_products) }
  end
end