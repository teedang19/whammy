require_relative "../spec_helper"

# TODO database cleaner

module Whammy
  describe Database do
    let(:db) { Database.new }
    let(:line_data) { ["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967"] }

    describe "#initialize" do
      it "defines @filename" do
        expect(db.instance_variable_get(:@filename)).to_not be_nil
      end

      it "sets @filename to the master db" do
        expect(db.instance_variable_get(:@filename)).to eql("database.txt")
      end
    end

    describe "#data_dir" do
      it "returns the path of the data directory" do
        expect(db.data_dir).to eql("data/")
      end
    end

    describe "#filename" do
      it "returns the path of the data file" do
        filename = db.instance_variable_get(:@filename)
        expect(db.filename).to eql("data/#{filename}")
      end
    end

    describe "#write!" do
      it "writes the data to the file" do
        filename = db.instance_variable_get(:@filename)
        db.write!(line_data)
        expect(File.read(db.filename)).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\n")
      end
    end
  end
end