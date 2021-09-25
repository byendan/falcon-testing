# frozen_string_literal: true

class Attribution
  def initialize(request_body)
    @params = request_body
  end

  def response
    Response.new(200, @params)
  end
end
