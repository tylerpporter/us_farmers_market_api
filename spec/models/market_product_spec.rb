require 'rails_helper'

RSpec.describe MarketProduct, type: :model do
  describe "relationships" do
    it { should belong_to :market }
    it { should belong_to :product }
  end
end