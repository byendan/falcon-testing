# frozen_string_literal: true

class AttributionStore < ActiveRecord::Base
  def self.async_save_attribution(attribution, session_id: SecureRandom.uuid)
    # need to do this async
    self.create!(session_id: session_id, attribution_json: attribution.to_json)
    session_id
  rescue => ex
    puts "Exception creating AttributionStore #{ex}"
    raise ex
  end

  def attribution_hash
    JSON.parse(attribution_json)
  end
end
