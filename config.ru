#!/usr/bin/env falcon --verbose serve -c
# frozen_string_literal: true

# require_relative 'config/environment'
require_relative 'lib/aggregate.rb'

class AggregateServer
  def initialize(app)
    @app = app
  end

  def call(env)
    # env.keys.each do |key, value|
    #   puts "-----------------"
    #   puts "#{key} = #{env[key].inspect}"
    #   puts "-----------------"
    # end
    #
    # puts env

    request_hash = Request.new(env).to_h
    response = case request_hash[:path]
               when '/'

                  Response.new(200, "Thanks for the request #{request_hash}")
               when '/hi'
                  Response.new(200, "The high road")
               else
                 Response.new(404, "Missed the path")
               end

    return response.to_formatted
  rescue => ex
    puts ex
    return @app.call(env)
  end
end

use AggregateServer

run ->(env) {
  [500, {}, ["Fail"]]
}
