require_relative "../../spec_helper"
require "rack/test"

module Whammy
  module V1
    describe API do
      include Rack::Test::Methods

      def app
        Whammy::V1::API
      end
    end
  end
end