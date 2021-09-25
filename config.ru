#!/usr/bin/env falcon --verbose serve -c
# frozen_string_literal: true

# require_relative 'config/environment'
require_relative 'lib/aggregate.rb'

class AggregateServer
  def initialize(app)
    @app = app
  end

  def call(env)
    # debug_env(env)
    request_hash = Request.new(env).to_h
    response = case request_hash[:path]
               when '/'
                  Response.new(200, "Thanks for the request #{request_hash}")
               when '/attribution'
                 Attribution.new(request_hash[:body_params]).response
               when '/list'
                 message = AttributionStore.all.map do |attribution_store|
                   attribution_store.session_id
                 end

                 Response.new(200, message)
               else
                 Response.new(404, "Missed the path")
               end

    return response.to_formatted
  rescue => ex
    puts ex
    return @app.call(env)
  end

  private

  def debug_env(env)
    env.keys.each do |key, value|
      puts "-----------------"
      puts "#{key} = #{env[key].inspect}"
      puts "-----------------"
    end

    puts env
  end
end

use AggregateServer

run ->(env) {
  [500, {}, ["Fail"]]
}
