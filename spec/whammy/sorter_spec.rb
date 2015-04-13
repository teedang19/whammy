require_relative "../spec_helper"

module Whammy
  describe Sorter do
    let(:sorter) { Sorter.new }

    before(:each) do
      allow(Database).to receive(:master_filename).and_return("spec/fixtures/files/example_db.txt")
    end

    describe "#initialize" do
      context "with a database" do
        it "reads from the passed-in database" do
          random_db = Database.new
          expect(random_db).to receive(:read).exactly(1).times
          Sorter.new(random_db)
        end
      end

      context "without a database" do
        it "reads from the master database" do
          expect(Database).to receive(:master_read).exactly(1).times
          Sorter.new
        end
      end
    end

    describe "#sort!" do
      context "by gender" do
        it "sorts @data by gender, female first, last name ascending" do
          expect(sorter.sort!(:gender)).to eql(
            [
              {
                last_name: "Schemel",
                first_name: "Patty",
                gender: "female",
                favorite_color: "orange",
                date_of_birth: "04/24/1967"
              },
              {
                last_name: "Reinhardt",
                first_name: "Django",
                gender: "male",
                favorite_color: "green",
                date_of_birth: "01/23/1910"
              },
              {
                last_name: "Schuldiner",
                first_name: "Chuck",
                gender: "male",
                favorite_color: "orange",
                date_of_birth: "05/13/1967"
              }
            ]
          )
        end
      end

      context "by birthdate" do
        it "sorts @data by birthdate, oldest first" do
          expect(sorter.sort!(:birthdate)).to eql(
            [
              {
                last_name: "Reinhardt",
                first_name: "Django",
                gender: "male",
                favorite_color: "green",
                date_of_birth: "01/23/1910"
              },
              {
                last_name: "Schemel",
                first_name: "Patty",
                gender: "female",
                favorite_color: "orange",
                date_of_birth: "04/24/1967"
              },
              {
                last_name: "Schuldiner",
                first_name: "Chuck",
                gender: "male",
                favorite_color: "orange",
                date_of_birth: "05/13/1967"
              }
            ]
          )
        end
      end

      context "by last_name desc" do
        it "sorts @data by last_name, desc" do
          expect(sorter.sort!(:last_name)).to eql(
            [
              {
                last_name: "Schuldiner",
                first_name: "Chuck",
                gender: "male",
                favorite_color: "orange",
                date_of_birth: "05/13/1967"
              },
              {
                last_name: "Schemel",
                first_name: "Patty",
                gender: "female",
                favorite_color: "orange",
                date_of_birth: "04/24/1967"
              },
              {
                last_name: "Reinhardt",
                first_name: "Django",
                gender: "male",
                favorite_color: "green",
                date_of_birth: "01/23/1910"
              }
            ]
          )
        end
      end

      context "without sorting" do
        it "returns @data" do
          expect(sorter.sort!).to eql(
            [
              {
                last_name: "Schemel",
                first_name: "Patty",
                gender: "female",
                favorite_color: "orange",
                date_of_birth: "04/24/1967"
              },
              {
                last_name: "Schuldiner",
                first_name: "Chuck",
                gender: "male",
                favorite_color: "orange",
                date_of_birth: "05/13/1967"
              },
              {
                last_name: "Reinhardt",
                first_name: "Django",
                gender: "male",
                favorite_color: "green",
                date_of_birth: "01/23/1910"
              }
            ]
          )
        end
      end
    end
  end
end