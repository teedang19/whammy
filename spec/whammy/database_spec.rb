require_relative "../spec_helper"

module Whammy
  describe Database do
    let(:temp_db) { Database.new(false) }
    let(:temp_filename) { DateTime.now.strftime("%m_%d_%y:%I_%M_%S.txt") }
    let(:master_db) { Database.new }
    let(:test_db) { "spec/fixtures/files/test_db.txt" }

    before(:each) do |example|
      unless example.metadata[:skip_before]
        allow_any_instance_of(Database).to receive(:data_filename).and_return(test_db)
      end
    end

    after(:each) do
      File.open(test_db, "w") {}
    end

    describe "#data_dir" do
      it "returns the path of the data directory" do
        expect(master_db.data_dir).to eql("data/")
      end
    end

    describe "#data_filename", :skip_before do
      context "wrtiing to master" do
        it "returns the path of the data file" do
          expect(master_db.data_filename).to eql("data/database.txt")
        end
      end

      context "writing to a new file" do
        it "returns the path of the data file" do
          expect(temp_db.data_filename).to eql("data/#{temp_filename}")
        end
      end
    end

    describe "#read" do
      before(:each) do
        allow_any_instance_of(Database).to receive(:data_filename).and_return("spec/fixtures/files/example_db.txt")
      end

      it "returns an array" do
        expect(master_db.read).to be_a(Array)
      end

      it "returns an array of hashes" do
        master_db.read.each do |element|
          expect(element).to be_a(Hash)
        end
      end

      it "returns the data from the database file" do
        expect(master_db.read).to eql(
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

    describe "#write_files" do
      it "writes each file to the db" do
        files = ["spec/fixtures/files/commas.txt", "spec/fixtures/files/pipes.txt"]
        master_db.write_files(files)
        expect(File.read(master_db.data_filename)).to eql("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\nReinhardt Django male green 01/23/1910\nShore Pauly male pink 02/01/1968\nSchwarzenegger Arnold male blue 07/30/1947\nMcDormand Frances female green 06/23/1957\n")
      end
    end

    describe "#write_file" do
      it "writes the file to the db" do
        file = "spec/fixtures/files/commas.txt"
        master_db.write_file(file)
        expect(File.read(master_db.data_filename)).to eql("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\nReinhardt Django male green 01/23/1910\n")
      end
    end

    describe "#write_line" do
      context "given a string" do
        context "space separated line" do
          it "writes the line to the db" do
            spaced_line = "Govan Guthrie male blue 12/27/1971\n"
            master_db.write_line(spaced_line)
            expect(File.read(master_db.data_filename)).to eql("Govan Guthrie male blue 12/27/1971\n")
          end
        end

        context "csv separated line" do
          it "writes the line to the db" do
            csv_line = "Shore, Pauly, male, pink, 02/01/1968\n"
            master_db.write_line(csv_line)
            expect(File.read(master_db.data_filename)).to eql("Shore Pauly male pink 02/01/1968\n")
          end
        end

        context "pipe separated line" do
          it "writes the line to the db" do
            piped_line = "Schuldiner | Chuck | male | orange | 05/13/1967\n"
            master_db.write_line(piped_line)
            expect(File.read(master_db.data_filename)).to eql("Schuldiner Chuck male orange 05/13/1967\n")
          end
        end
      end

      context "given a hash" do
        context "with out-of-order attributes" do
          it "writes the attributes in the correct order" do
            out_of_order = {
              first_name: "Guthrie",
              favorite_color: "blue",
              last_name: "Govan",
              date_of_birth: "12/27/1971",
              gender: "male"
            }
            master_db.write_line(out_of_order)
            expect(File.read(master_db.data_filename)).to eql("Govan Guthrie male blue 12/27/1971\n")
          end
        end

        context "with too few attributes" do
          it "raises an error" do
            too_few = { first_name: "Guthrie", date_of_birth: "12/27/1971" }
            expect{master_db.write_line(too_few)}.to raise_error(ArgumentError)
          end
        end

        context "with more than enough attributes" do
          it "writes only the needed attributes" do
            more_than_enough = {
              eye_color: "hazel",
              first_name: "Guthrie",
              profession: "guitarist",
              favorite_color: "blue",
              last_name: "Govan",
              date_of_birth: "12/27/1971",
              gender: "male"
            }
            master_db.write_line(more_than_enough)
            expect(File.read(master_db.data_filename)).to eql("Govan Guthrie male blue 12/27/1971\n")
          end
        end
      end
    end
  end
end