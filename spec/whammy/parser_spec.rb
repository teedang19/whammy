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

    describe "#parse_line" do
      context "when given a comma-delimited line" do
        xit "returns the line parsed" do
        end
      end

      context "when given a pipe-delimited line" do
        xit "returns the line parsed" do
        end
      end

      context "when given a space-delimited line" do
        xit "returns the line parsed" do
        end
      end
    end

    describe "#delimiter" do
      let(:csv_line) { "Govan, Guthrie, male, blue, 12/27/1971" }
      let(:piped_line) { "Shore | Pauly | male | pink | 02/01/1968" }
      let(:spaced_line) { "Dang Tam female purple 01/13/1990" }

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