require_relative "../spec_helper"

module Whammy
  describe Database do
    let(:db) { Database.new }
    let(:files) { ["commas.txt"] }
    let(:line_data) { ["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967"] }

    before(:each) do |example|
      unless example.metadata[:skip_before]
        allow_any_instance_of(Database).to receive(:data_file).and_return("data/test.txt")
      end
    end

    after(:each) do
      File.open("data/test.txt", "w") {}
    end

    describe "#initialize" do
      it "defines @filename" do
        expect(db.instance_variable_get(:@filename)).to_not be_nil
      end

      it "sets @filename to the master db" do
        expect(db.instance_variable_get(:@filename)).to eql("database.txt")
      end

      it "defines @parser" do
        expect(db.instance_variable_get(:@parser)).to_not be_nil
      end

      it "sets @parser to a new Parser" do
        expect(db.instance_variable_get(:@parser)).to be_a(Parser)
      end
    end

    describe "#data_dir" do
      it "returns the path of the data directory" do
        expect(db.data_dir).to eql("data/")
      end
    end

    describe "#data_file", :skip_before do
      it "returns the path of the data file" do
        filename = db.instance_variable_get(:@filename)
        expect(db.data_file).to eql("data/#{filename}")
      end
    end

    describe "#read" do
      it "returns an array" do
        expect(db.read).to be_a(Array)
      end

      it "returns an array of hashes" do
        db.read.each do |element|
          expect(element).to be_a(Hash)
        end
      end

      it "returns the data from the database file" do
        db.write_files(files)
        expect(db.read).to eql([{last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"},{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"},{last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
      end
    end

    describe "#write_files" do
      it "writes the data to the file" do
        db.write_files(files)
        expect(File.read(db.data_file)).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\n")
      end
    end

    describe "#write_lines" do
      it "writes the lines to the file" do
        db.write_lines(line_data)
        expect(File.read(db.data_file)).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\n")
      end
    end
  end
end