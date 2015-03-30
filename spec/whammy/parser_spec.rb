require_relative "../spec_helper"

module Whammy
  describe Parser do
    let(:files) { ["commas.txt", "pipes.txt"] }
    let(:parser) { Parser.new(files) }

    describe "#initialize" do
      it "defines @files" do
        expect(parser.instance_variable_get(:@files)).to_not be_nil
      end
    end

    describe "#parse!" do
      it "passes each file to #parse_file" do
        expect(parser).to receive(:parse_file).with(files[0])
        expect(parser).to receive(:parse_file).with(files[1])
        parser.parse!
      end

      it "returns the files parsed" do
        expect(parser.parse!).to eql([[["Govan", "Guthrie", "male", "blue", "12/27/1971"], ["Schuldiner", "Chuck", "male", "orange", "05/13/1967"], ["Reinhardt", "Django", "male", "green", "01/23/1910"]],[["Shore", "Pauly", "male", "pink", "02/01/1968"], ["Schwarzenegger", "Arnold", "male", "blue", "07/30/1947"], ["McDormand", "Frances", "female", "green", "06/23/1957"]]])
      end
    end

    describe "#parse_file" do
      let(:csv_file) { "commas.txt"}
      let(:spaced_file) { "spaces.txt"}
      let(:piped_file) { "pipes.txt"}

      it "passes each line of a file to #parse_line" do
        comma_line_count = File.foreach(csv_file).count
        expect(parser).to receive(:parse_line).exactly(comma_line_count).times
        parser.parse_file(csv_file)
      end

      context "called with a comma-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(csv_file)).to eql([["Govan", "Guthrie", "male", "blue", "12/27/1971"], ["Schuldiner", "Chuck", "male", "orange", "05/13/1967"], ["Reinhardt", "Django", "male", "green", "01/23/1910"]])
        end
      end

      context "called with a space-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(spaced_file)).to eql([["Dang", "Tam", "female", "purple", "01/13/1990"], ["Baldissero", "Shawn", "male", "green", "02/03/1987"], ["TranNgoc", "Tuyen", "female", "red", "01/13/1952"]])
        end
      end

      context "called with a pipe-delimited file" do
        it "parses the file" do
          expect(parser.parse_file(piped_file)).to eql([["Shore", "Pauly", "male", "pink", "02/01/1968"], ["Schwarzenegger", "Arnold", "male", "blue", "07/30/1947"], ["McDormand", "Frances", "female", "green", "06/23/1957"]])
        end
      end
    end

    let(:csv_line) { "Govan, Guthrie, male, blue, 12/27/1971" }
    let(:piped_line) { "Shore | Pauly | male | pink | 02/01/1968" }
    let(:spaced_line) { "Dang Tam female purple 01/13/1990" }
    let(:contains_newline) { "Shore | Pauly | male | pink | 02/01/1968\n" }

    describe "#parse_line" do
      it "removes newlines" do
        expect(parser.parse_line(contains_newline)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
      end

      context "called with a comma-delimited line" do
        it "parses the line" do
          expect(parser.parse_line(csv_line)).to eql(["Govan", "Guthrie", "male", "blue", "12/27/1971"])
        end

        it "returns an array" do
          expect(parser.parse_line(csv_line)).to be_a(Array)
        end
      end

      context "called with a pipe-delimited line" do
        it "parses the line" do
          expect(parser.parse_line(piped_line)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
        end

        it "returns an array" do
          expect(parser.parse_line(piped_line)).to be_a(Array)
        end
      end

      context "called with a space-delimited line" do
        it "parses the line" do
          expect(parser.parse_line(spaced_line)).to eql(["Dang", "Tam", "female", "purple", "01/13/1990"])
        end

        it "returns an array" do
          expect(parser.parse_line(spaced_line)).to be_a(Array)
        end
      end
    end

    describe "#delimiter" do
      context "called with a comma-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter(csv_line)).to eql(/, /)
        end

        it "returns a regexp" do
          expect(parser.delimiter(csv_line)).to be_a(Regexp)
        end
      end

      context "called with a pipe-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter(piped_line)).to eql(/ \| /)
        end

        it "returns a regexp" do
          expect(parser.delimiter(piped_line)).to be_a(Regexp)
        end
      end

      context "called with a space-delimited line" do
        it "returns the correct delimiter" do
          expect(parser.delimiter(spaced_line)).to eql(/ /)
        end

        it "returns a regexp" do
          expect(parser.delimiter(spaced_line)).to be_a(Regexp)
        end
      end
    end
  end
end