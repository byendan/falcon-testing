# frozen_string_literal: true

require_relative '../test_lib'

describe Request do
  describe "#to_h" do
    before do
      async_request_object = setup_request_double

      @env = {
        "async.http.request" => async_request_object,
        "PATH_INFO" => "/one/two",
        "QUERY_STRING" => "three=3&four=4"
      }

      @request = Request.new(@env)
    end

    it "returns path" do
      expect(@request.to_h[:path]).to eq("/one/two")
    end

    describe ":query_params" do
      it "returns a parsed query string" do
        expect(@request.to_h[:query_params]).to eq({ "three" => "3", "four" => "4" })
      end

      it "decodes uri components" do
        temp_env = @env.merge({ "QUERY_STRING" => "thirteen-one=13-1.il%20jfe" })
        request = Request.new(temp_env)
        expect(request.to_h[:query_params]).to eq({ "thirteen-one" => "13-1.il jfe" })
      end
    end
  end

  def setup_request_double
    params = {
      body?: true,
      body: double("Request Body", read: {
          "attribution" => {
            "product_name" => "snuggies",
            "product_demo" => "dogs",
            "product_category" => "cozy"
          }
        }.to_json
      )
    }
    double("Async::Http::Request", params)
  end
end
