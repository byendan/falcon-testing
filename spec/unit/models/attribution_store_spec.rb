# frozen_string_literal: true

require_relative '../test_lib'

describe AttributionStore do
  describe "#async_save_attribution" do
    it "returns a new id if none was given" do
      id = AttributionStore.async_save_attribution({ one: 1 })
      expect(id).to be_a(String)
      expect(id.length > 4).to eq(true)
    end

    it "returns the same id if one was given" do
      id = AttributionStore.async_save_attribution({ two: 2 }, session_id: "123")
      expect(id).to eq("123")
    end

    it "saves a new record with the attribution" do
      attribution_params = {
        "product_name" => "snuggies",
        "product_demo" => "dogs",
        "product_category" => "cozy"
      }

      AttributionStore.async_save_attribution(attribution_params, session_id: "123")
      new_attribution = AttributionStore.where(session_id: "123").first
      expect(new_attribution.attribution_hash).to eq(attribution_params)
    end
  end
end
