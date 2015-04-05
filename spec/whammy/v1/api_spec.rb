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
        let(:test_db) { "spec/fixtures/files/test_db.txt" }

        before(:each) do
          allow_any_instance_of(Database).to receive(:data_file).and_return(test_db)
        end

        after(:each) do
          File.open(test_db, "w") {}
        end

        it "returns the posted record" do
          post "/api/v1/records", record: { last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971" }
          expect(JSON.parse(last_response.body)).to eql({"last_name"=>"Govan", "first_name"=>"Guthrie", "gender"=>"male", "favorite_color"=>"blue", "date_of_birth"=>"12/27/1971"})
        end

        it "returns a 201 status" do
          post "/api/v1/records", record: { last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971" }
          expect(last_response.status).to eql(201)
        end

        context "with out of order params" do
          it "writes the record to the db" do
            post "/api/v1/records", record: { gender: "female", first_name: "Patty", favorite_color: "orange", date_of_birth: "04/24/1967", last_name: "Schemel" }
            expect(File.read(test_db)).to eql("Schemel Patty female orange 04/24/1967\n")
          end
        end

        context "with params in order" do
          it "writes the record to the db" do
            post "/api/v1/records", record: { last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971" }
            expect(File.read(test_db)).to eql("Govan Guthrie male blue 12/27/1971\n")
          end
        end

        context "with more than enough params" do
          it "writes the record to the db" do
            post "/api/v1/records", record: { profession: "musician", last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", eye_color: "hazel", date_of_birth: "12/27/1971" }
            expect(File.read(test_db)).to eql("Govan Guthrie male blue 12/27/1971\n")
          end
        end

        context "with too few params" do
          it "doesn't allow records to post" do
            post "/api/v1/records", record: { last_name: "Govan", first_name: "Guthrie", favorite_color: "blue", date_of_birth: "12/27/1971" }
            expect(JSON.parse(last_response.body)).to eql({"error"=> "record[gender] is missing"})
          end

          it "returns a 400" do
            post "/api/v1/records", record: { last_name: "Govan", first_name: "Guthrie", favorite_color: "blue", date_of_birth: "12/27/1971" }
            expect(last_response.status).to eql(400)
          end
        end
      end

      let(:example_db) { "spec/fixtures/files/example_db.txt" }

      before(:each) do
        allow_any_instance_of(Database).to receive(:data_file).and_return(example_db)
      end

      describe "GET /api/v1/records/gender" do
        before(:each) { get "api/v1/records/gender" }

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end

        it "returns records sorted by gender: women first && last name asc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}, {"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}]})
        end
      end

      describe "GET /api/v1/records/birthdate" do
        before(:each) { get "api/v1/records/birthdate" }

        it "returns records sorted birthdate, asc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}, {"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}]})
        end

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end
      end

      describe "GET /api/v1/records/name" do
        before(:each) { get "api/v1/records/name" }

        it "returns records sorted last_name desc" do
          expect(JSON.parse(last_response.body)).to eq({"records"=>[{"last_name"=>"Schuldiner", "first_name"=>"Chuck", "gender"=>"male", "favorite_color"=>"orange", "date_of_birth"=>"05/13/1967"}, {"last_name"=>"Schemel", "first_name"=>"Patty", "gender"=>"female", "favorite_color"=>"orange", "date_of_birth"=>"04/24/1967"}, {"last_name"=>"Reinhardt", "first_name"=>"Django", "gender"=>"male", "favorite_color"=>"green", "date_of_birth"=>"01/23/1910"}]})
        end

        it "returns a 200 status" do
          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end