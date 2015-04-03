require_relative "../spec_helper"

module Whammy
  describe Parser do
    let(:files) { ["commas.txt", "pipes.txt"] }
    let(:file) { files[0] }
    let(:parser) { Parser.new }

    describe "#line_data" do
      it "returns an array of strings" do
        expect(parser.line_data(files)).to be_a(Array)
        parser.line_data(files).each { |element| expect(element).to be_a(String) }
      end

      it "returns the lines of all the files" do
        expect(parser.line_data(files)).to eql(["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967", "Reinhardt Django male green 01/23/1910", "Shore Pauly male pink 02/01/1968", "Schwarzenegger Arnold male blue 07/30/1947", "McDormand Frances female green 06/23/1957"])
      end
    end

    describe "#lineify" do
      it "returns an array of strings" do
        expect(parser.lineify(file)).to be_a(Array)
        parser.lineify(file).each { |element| expect(element).to be_a(String) }
      end

      it "returns the file as an array of lines" do
        expect(parser.lineify(file)).to eql(["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967", "Reinhardt Django male green 01/23/1910"])
      end
    end

    describe "#parse" do
      let(:csv_file) { "commas.txt" }
      let(:spaced_file) { "spaces.txt" }
      let(:piped_file) { "pipes.txt" }

      context "called with a comma-delimited file" do
        it "parses the file" do
          expect(parser.parse(csv_file)).to eql([{ last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
        end
      end

      context "called with a space-delimited file" do
        it "parses the file" do
          expect(parser.parse(spaced_file)).to eql([{ last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "purple", date_of_birth: "01/13/1990" }, {last_name: "Baldissero", first_name: "Shawn", gender: "male", favorite_color: "green", date_of_birth: "02/03/1987"}, {last_name: "TranNgoc", first_name: "Tuyen", gender: "female", favorite_color: "red", date_of_birth: "01/13/1952"} ])
        end
      end

      context "called with a pipe-delimited file" do
        it "parses the file" do
          expect(parser.parse(piped_file)).to eql([{ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"}, {last_name: "Schwarzenegger", first_name: "Arnold", gender: "male", favorite_color: "blue", date_of_birth: "07/30/1947"}, {last_name: "McDormand", first_name: "Frances", gender: "female", favorite_color: "green", date_of_birth: "06/23/1957"} ])
        end
      end
    end

    let(:csv_line) { "Govan, Guthrie, male, blue, 12/27/1971" }
    let(:piped_line) { "Shore | Pauly | male | pink | 02/01/1968" }
    let(:spaced_line) { "Dang Tam female purple 01/13/1990" }

    describe "#parse_line!" do
      context "called with a comma-delimited line" do
        xit "returns a hash of the line attributes" do
          expect(parser.parse_line!(csv_line)).to eql({ last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"})
        end
      end

      context "called with a pipe-delimited line" do
        xit "returns a hash of the line attributes" do
          expect(parser.parse_line!(piped_line)).to eql({ last_name: "Shore", first_name: "Pauly", gender: "male", favorite_color: "pink", date_of_birth: "02/01/1968"})
        end
      end

      context "called with a space-delimited line" do
        xit "returns a hash of the line attributes" do
          expect(parser.parse_line!(spaced_line)).to eql({ last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "purple", date_of_birth: "01/13/1990" })
        end
      end
    end

    let(:contains_newline) { "Shore | Pauly | male | pink | 02/01/1968\n" }

    describe "#split" do
      it "removes newlines" do
        expect(parser.split(contains_newline)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
      end

      context "called with a comma-delimited line" do
        it "parses the line" do
          expect(parser.split(csv_line)).to eql(["Govan", "Guthrie", "male", "blue", "12/27/1971"])
        end
        it "returns an array" do
          expect(parser.split(csv_line)).to be_a(Array)
        end
      end

      context "called with a pipe-delimited line" do
        it "parses the line" do
          expect(parser.split(piped_line)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
        end
        it "returns an array" do
          expect(parser.split(piped_line)).to be_a(Array)
        end
      end

      context "called with a space-delimited line" do
        it "parses the line" do
          expect(parser.split(spaced_line)).to eql(["Dang", "Tam", "female", "purple", "01/13/1990"])
        end
        it "returns an array" do
          expect(parser.split(spaced_line)).to be_a(Array)
        end
      end
    end

    describe "#delimiter_of" do
      context "called with a comma-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(csv_line)).to eql(/, /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(csv_line)).to be_a(Regexp)
        end
      end

      context "called with a pipe-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(piped_line)).to eql(/ \| /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(piped_line)).to be_a(Regexp)
        end
      end

      context "called with a space-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter_of(spaced_line)).to eql(/ /)
        end
        it "returns a regexp" do
          expect(parser.delimiter_of(spaced_line)).to be_a(Regexp)
        end
      end
    end

    describe "#attributeify" do
      let(:values_arr) { ["Govan", "Guthrie", "male", "blue", "12/27/1971"] }

      it "raises an ArgumentError with a line of the incorrect length" do
        too_long_arr = values_arr.push("potatoes")
        expect{ parser.attributeify(too_long_arr) }.to raise_error(ArgumentError)
      end

      it "hashes the array into attributes" do
        expect(parser.attributeify(values_arr)).to eql({ last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"})
      end
    end
  end
end