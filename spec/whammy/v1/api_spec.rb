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
        before(:each) { get "api/v1/records/gender" }

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end

        it "returns database records sorted by gender: women first && last name asc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Dang", "first_name"=>"Tam", "gender"=>"female", "favorite_color"=>"blue", "date_of_birth"=>"01/13/1990"}, {"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Govan", "first_name"=>"Guthrie", "gender"=>"male", "favorite_color"=>"blue", "date_of_birth"=>"12/27/1971"}, {"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}, {"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}]})
        end
      end

      describe "GET /api/v1/records/birthdate" do
        before(:each) { get "api/v1/records/birthdate" }

        it "returns database records sorted birthdate, asc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}, {"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}, {"last_name"=>"Govan", "first_name"=>"Guthrie", "gender"=>"male", "favorite_color"=>"blue", "date_of_birth"=>"12/27/1971"}, {"last_name"=>"Dang", "first_name"=>"Tam", "gender"=>"female", "favorite_color"=>"blue", "date_of_birth"=>"01/13/1990"}]})
        end

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end
      end

      describe "GET /api/v1/records/name" do
        before(:each) { get "api/v1/records/name" }

        it "returns database records sorted last_name desc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}, {"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}, {"last_name"=>"Govan", "first_name"=>"Guthrie", "gender"=>"male", "favorite_color"=>"blue", "date_of_birth"=>"12/27/1971"}, {"last_name"=>"Dang", "first_name"=>"Tam", "gender"=>"female", "favorite_color"=>"blue", "date_of_birth"=>"01/13/1990"}]})
        end

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end