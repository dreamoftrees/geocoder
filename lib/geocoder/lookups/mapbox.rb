require 'cgi'
require 'geocoder/lookups/base'
require "geocoder/results/mapbox"

module Geocoder::Lookup
  class Mapbox < Base
    def name
      "Mapbox"
    end

    def required_api_key_parts
      ["key"]
    end

    def supported_protocols
      [:https]
    end

    def query_url(query)
      #"#{protocol}://maps.googleapis.com/maps/api/place/details/json?#{url_query_string(query)}"
      "#{protocol}://api.tiles.mapbox.com/v4/geocode/#{dataset}/#{URI.escape(query.sanitized_text.strip)}+3.json?#{hash_to_query(mapbox_params)}"
    end

    private

    def results(query)
      return [] unless doc = fetch_data(query)

      # case doc["status"]
      # when "OK"
      #   return [doc["result"]]
      # when "OVER_QUERY_LIMIT"
      #   raise_error(Geocoder::OverQueryLimitError) || Geocoder.log(:warn, "Google Places Details API error: over query limit.")
      # when "REQUEST_DENIED"
      #   raise_error(Geocoder::RequestDenied) || Geocoder.log(:warn, "Google Places Details API error: request denied.")
      # when "INVALID_REQUEST"
      #   raise_error(Geocoder::InvalidRequest) || Geocoder.log(:warn, "Google Places Details API error: invalid request.")
      # end

      []
    end

    def query_url_params(query)
      {
          :access_token => configuration.api_key
      }.merge(super)
    end

    def dataset
      configuration[:dataset] || "mapbox.places"
    end

    def mapbox_params
      {
          access_token: configuration.api_key
      }
    end
  end
end
