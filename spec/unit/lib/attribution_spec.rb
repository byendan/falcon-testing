# frozen_string_literal: true

require_relative '../test_lib'

describe Attribution do
  describe "#response" do
    before do
      @attribution_params = {
        "product_name" => "snuggies",
        "product_demo" => "dogs",
        "product_category" => "cozy"
      }
    end

    it "returns the attribution in the response" do
      attribution = Attribution.new(@attribution_params)
      expect(attribution.response).to be_a(Response)
      expect(attribution.response.to_formatted).to eq([200, {}, [@attribution_params]])
    end
  end

  it "creates a record with the same attribution" do
    Attribution.new(@attribution_params).response
    attribution_store = AttributionStore.last
    expect(attribution_store.attribution_hash).to eq(@attribution_params)
  end
end
