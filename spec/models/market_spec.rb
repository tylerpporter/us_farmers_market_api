require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "relationships" do
    it { should have_many :market_products }
    it { should have_many(:products).through(:market_products) }
  end
end
