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
        before(:each) do
          allow_any_instance_of(Database).to receive(:data_file).and_return("data/test.txt")
        end

        after(:each) do
          File.open("data/test.txt", "w") {}
        end

        xit "posts a JSON record" do
        end

        xit "doesn't allow records to post without proper parameters" do
        end

        xit "returns the posted record" do
        end

        xit "returns a 301 for posted records" do
        end
      end

      before(:each) do |example|
        allow_any_instance_of(Database).to receive(:data_file).and_return("data/example_db.txt")
      end

      describe "GET /api/v1/records/gender" do
        xit "returns database records sorted by gender" do
        end

        it "returns a 200 status" do
          get "api/v1/records/gender"
          expect(last_response.status).to eq(200)
        end
      end

      describe "GET /api/v1/records/birthdate" do
        xit "returns database records sorted by birthdate" do
        end

        it "returns a 200 status" do
          get "api/v1/records/birthdate"
          expect(last_response.status).to eq(200)
        end
      end

      describe "GET /api/v1/records/name" do
        xit "returns database records sorted by last_name" do
        end

        it "returns a 200 status" do
          get "api/v1/records/name"
          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end