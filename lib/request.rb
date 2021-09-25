# frozen_string_literal: true

require 'cgi'

class Request
  def initialize(env)
    @path = env["PATH_INFO"]
    @query_params = parse_query_params(env["QUERY_STRING"])
    @body_params = parse_body_params(env["async.http.request"])
  end

  def path
    @path
  end

  def query_params
    @query_params
  end

  def body_params
    @body_params
  end

  def to_h
    {
      path: @path,
      query_params: @query_params,
      body_params: @body_params
    }
  end

  private

  def parse_query_params(query_string)
    CGI::parse(query_string).reduce({}) do |query_hash, (key, value)|
      if value.is_a?(Array) && value.length == 1
        query_hash[key] = value.first
      end

      query_hash
    end
  end

  def parse_body_params(async_http_request)
    if async_http_request.body?
      JSON.parse(async_http_request.body.read)
    else
      {}
    end
  end
end
