# frozen_string_literal: true

class Response
  def initialize(status_code, message)
    @status_code = status_code
    @message = message
  end

  def to_formatted
    [@status_code, {}, [@message]]
  end
end
