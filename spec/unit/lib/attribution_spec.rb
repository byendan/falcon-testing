# frozen_string_literal: true

require_relative '../test_lib'

describe Attribution do
  describe "#response" do
    it "responds with the attribution in the response message" do
      attribution_params = {
        "product_name" => "snuggies",
        "product_demo" => "dogs",
        "product_category" => "cozy"
      }

      attribution = Attribution.new(attribution_params)
      expect(attribution.response).to be_a(Response)
      expect(attribution.response.to_formatted).to eq([200, {}, [attribution_params]])
    end
  end
end
