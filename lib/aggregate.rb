# frozen_string_literal: true

require_relative '../config/environment'
require 'active_support'
require 'active_support/all'

require 'bundler'
require 'json'
require 'active_record'

# classes
require_relative 'response'
require_relative 'request'
require_relative 'attribution'

# models
require_relative '../app/models/attribution_store'
