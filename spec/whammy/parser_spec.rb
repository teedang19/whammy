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
  end
end