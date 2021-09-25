# frozen_string_literal: true

class Attribution
  def initialize(request_body)
    @params = request_body
  end

  def response
    attribution_id = store_attribution(@params)
    # put the attribution id into a header cookie
    Response.new(200, @params)
  end

  private

  def store_attribution(attribution_params)
    AttributionStore.async_save_attribution(attribution_params)
  end
end
