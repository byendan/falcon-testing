# frozen_string_literal: true

require_relative '../test_lib'

describe Response do
  describe "formatting" do
    it "returns a status header and message" do
      response = Response.new(200, "Success")
      expect(response.to_formatted).to eq([200, {}, ["Success"]])
    end
  end
end
