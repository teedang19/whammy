require_relative "../spec_helper"

# TODO database cleaner

module Whammy
  describe Database do
    let(:master_db) { Database.new(true) }
    let(:temp_db) { Database.new(false) }
    let(:line_data) { ["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967"] }

    describe "#initialize" do
      context "when writing to master" do
        it "defines @filename" do
          expect(master_db.instance_variable_get(:@filename)).to_not be_nil
        end

        it "sets @filename to the master db" do
          expect(master_db.instance_variable_get(:@filename)).to eql("database.txt")
        end
      end

      context "when writing to a new file" do
        it "defines @filename" do
          expect(temp_db.instance_variable_get(:@filename)).to_not be_nil
        end

        it "sets @filename to a Timestamp string" do
          expect(temp_db.instance_variable_get(:@filename)).to eql(DateTime.now.strftime("%m_%e_%y:%k_%M.txt"))
        end
      end
    end

    describe "#data_dir" do
      context "when writing to master" do
        it "returns the path of the data directory" do
          expect(master_db.data_dir).to eql("data/")
        end
      end

      context "when writing to a new file" do
        it "returns the path of the data directory" do
          expect(temp_db.data_dir).to eql("data/")
        end
      end
    end

    describe "#filename" do
      context "when writing to master" do
        it "returns the path of the data file" do
          filename = master_db.instance_variable_get(:@filename)
          expect(master_db.filename).to eql("data/#{filename}")
        end
      end

      context "when writing to a new file" do
        it "returns the path of the data file" do
          filename = temp_db.instance_variable_get(:@filename)
          expect(temp_db.filename).to eql("data/#{filename}")
        end
      end
    end

    describe "#write_data!" do
      context "when writing to master" do
        it "writes the data to the file" do
          filename = master_db.instance_variable_get(:@filename)
          master_db.write_data!(line_data)
          expect(File.read(master_db.filename)).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\n")
        end
      end

      context "when writing to a new file" do
        it "writes the data to the file" do
          filename = temp_db.instance_variable_get(:@filename)
          temp_db.write_data!(line_data)
          expect(File.read(temp_db.filename)).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\n")
        end
      end
    end
  end
end