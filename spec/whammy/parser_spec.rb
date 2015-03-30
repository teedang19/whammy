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

      xit "returns the files parsed" do
      end
    end

    describe "#parse_file" do
      it "passes each line of a file to #parse_line" do
        comma_file = "commas.txt"
        comma_line_count = File.foreach(comma_file).count
        expect(parser).to receive(:parse_line).exactly(comma_line_count).times
        parser.parse_file(comma_file)
      end

      xit "returns the file parsed" do
      end
    end

    let(:csv_line) { "Govan, Guthrie, male, blue, 12/27/1971" }
    let(:piped_line) { "Shore | Pauly | male | pink | 02/01/1968" }
    let(:spaced_line) { "Dang Tam female purple 01/13/1990" }
    let(:contains_newline) { "Shore | Pauly | male | pink | 02/01/1968\n" }

    describe "#parse_line" do

      it "returns an array" do
        expect(parser.parse_line(csv_line)).to be_a(Array)
        expect(parser.parse_line(piped_line)).to be_a(Array)
        expect(parser.parse_line(spaced_line)).to be_a(Array)
        expect(parser.parse_line(contains_newline)).to be_a(Array)
      end

      it "removes newlines" do
        expect(parser.parse_line(contains_newline)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
      end

      context "when given a comma-delimited line" do
        it "returns the line parsed" do
          expect(parser.parse_line(csv_line)).to eql(["Govan", "Guthrie", "male", "blue", "12/27/1971"])
        end
      end

      context "when given a pipe-delimited line" do
        it "returns the line parsed" do
          expect(parser.parse_line(piped_line)).to eql(["Shore", "Pauly", "male", "pink", "02/01/1968"])
        end
      end

      context "when given a space-delimited line" do
        it "returns the line parsed" do
          expect(parser.parse_line(spaced_line)).to eql(["Dang", "Tam", "female", "purple", "01/13/1990"])
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
        it "returns nil" do
          expect(parser.delimiter(spaced_line)).to eql(nil)
        end
      end
    end
  end
end