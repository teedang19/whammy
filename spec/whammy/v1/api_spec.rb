require_relative "../../spec_helper"
require "rack/test"

module Whammy
  module V1
    describe API do
      include Rack::Test::Methods

      def app
        Whammy::V1::API
      end

      describe "POST /api/v1/records" do
        xit "posts a JSON record" do
        end

        xit "doesn't allow records to post without proper parameters" do
        end

        xit "returns the posted record" do
        end

        xit "returns a 301 for posted records" do
        end
      end

      describe "GET /api/v1/records/gender" do
        xit "returns database records sorted by gender" do
        end

        xit "returns a 200" do
        end
      end

      describe "GET /api/v1/records/birthdate" do
        xit "returns database records sorted by birthdate" do
        end

        xit "returns a 200" do
        end
      end

      describe "GET /api/v1/records/name" do
        xit "returns database records sorted by last_name" do
        end

        xit "returns a 200" do
        end
      end
    end
  end
end