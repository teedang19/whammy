require_relative "../spec_helper"

module Whammy
  describe Parser do
    let(:parser) { Parser.new }

    describe "#parse_file" do
      let(:csv_file) { "spec/fixtures/files/commas.txt" }
      let(:spaced_file) { "spec/fixtures/files/spaces.txt" }
      let(:piped_file) { "spec/fixtures/files/pipes.txt" }

      context "with a comma-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(csv_file)).to eql([{ last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
        end
      end

      context "with a space-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(spaced_file)).to eql([{ last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "purple", date_of_birth: "01/13/1990" }, {last_name: "Baldissero", first_name: "Shawn", gender: "male", favorite_color: "green", date_of_birth: "02/03/1987"}, {last_name: "TranNgoc", first_name: "Tuyen", gender: "female", favorite_color: "red", date_of_birth: "01/13/1952"} ])
        end
      end

      context "with a pipe-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(piped_file)).to eql([{ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"}, {last_name: "Schwarzenegger", first_name: "Arnold", gender: "male", favorite_color: "blue", date_of_birth: "07/30/1947"}, {last_name: "McDormand", first_name: "Frances", gender: "female", favorite_color: "green", date_of_birth: "06/23/1957"} ])
        end
      end
    end

    describe "#parse_entry" do
      context "given a string" do
        let(:valid_str) { "Shore | Pauly | male | pink | 02/01/1968" }
        let(:invalid_str) { "Emmanuel | Rahm | male | green" }

        it "returns the string as a hash of attributes" do
          expect(parser.parse_entry(valid_str)).to eql({ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"})
        end

        it "raises an error for invalid length strings" do
          expect{ parser.parse_entry(invalid_str) }.to raise_error(ArgumentError)
        end
      end

      context "given a hash" do
        let(:out_of_order) { { first_name: "Pauly", gender: "male", date_of_birth: "02/01/1968", last_name: "Shore", favorite_color: "pink" } }
        let(:too_few) { { last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink" } }
        let(:big) { { last_name: "Shore", first_name: "Pauly", favorite_movie: "Inceno Man", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968" } }

        it "returns the hash in the correct order" do
          expect(parser.parse_entry(out_of_order)).to eql({ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"})
        end

        it "raises an error for hashes with too few attributes" do
          expect{ parser.parse_entry(too_few) }.to raise_error(ArgumentError)
        end

        it "works for hashes with extra attributes" do
          expect(parser.parse_entry(big)).to eql({ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"})
        end
      end
    end

    describe "#is_valid?" do
      xit "TODO" do
      end
    end

    describe "#all_values_present?" do
      xit "TODO" do
      end
    end

    describe "#ordered_attributes" do
      xit "TODO" do
      end
    end

    let(:file) { "spec/fixtures/files/commas.txt" }

    describe "#split_lines" do
      it "returns an array" do
        expect(parser.split_lines(file)).to be_a(Array)
      end

      it "returns an array of arrays" do
        parser.split_lines(file).each do |element|
          expect(element).to be_a(Array)
        end
      end

      it "returns the file as an array of split lines" do
        expect(parser.split_lines(file)).to eql([["Govan", "Guthrie", "male", "blue", "12/27/1971"], ["Schuldiner", "Chuck", "male", "orange", "05/13/1967"], ["Reinhardt", "Django", "male", "green", "01/23/1910"]])
      end
    end

    let(:csv_line) { "Govan, Guthrie, male, blue, 12/27/1971" }
    let(:piped_line) { "Shore | Pauly | male | pink | 02/01/1968" }
    let(:spaced_line) { "Dang Tam female purple 01/13/1990" }
    let(:contains_newline) { "Shore | Pauly | male | pink | 02/01/1968\n" }

    describe "#split" do
      it "removes newlines" do
        expect(parser.split(contains_newline)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
      end

      context "with a comma-delimited line" do
        it "parses the line" do
          expect(parser.split(csv_line)).to eql(["Govan", "Guthrie", "male", "blue", "12/27/1971"])
        end
        it "returns an array" do
          expect(parser.split(csv_line)).to be_a(Array)
        end
      end

      context "with a pipe-delimited line" do
        it "parses the line" do
          expect(parser.split(piped_line)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
        end
        it "returns an array" do
          expect(parser.split(piped_line)).to be_a(Array)
        end
      end

      context "with a space-delimited line" do
        it "parses the line" do
          expect(parser.split(spaced_line)).to eql(["Dang", "Tam", "female", "purple", "01/13/1990"])
        end
        it "returns an array" do
          expect(parser.split(spaced_line)).to be_a(Array)
        end
      end
    end

    describe "#delimiter_of" do
      context "with a comma-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(csv_line)).to eql(/, /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(csv_line)).to be_a(Regexp)
        end
      end

      context "with a pipe-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(piped_line)).to eql(/ \| /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(piped_line)).to be_a(Regexp)
        end
      end

      context "with a space-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(spaced_line)).to eql(/ /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(spaced_line)).to be_a(Regexp)
        end
      end
    end

    describe "#set_attributes" do
      let(:values_arr) { ["Govan", "Guthrie", "male", "blue", "12/27/1971"] }

      it "raises an ArgumentError with an array of the incorrect length" do
        too_long_arr = values_arr.push("potatoes")
        expect{ parser.set_attributes(too_long_arr) }.to raise_error(ArgumentError)
      end

      it "hashes the array into attributes" do
        expect(parser.set_attributes(values_arr)).to eql({ last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"})
      end
    end
  end
end