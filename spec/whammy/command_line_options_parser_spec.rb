require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:parser) { CommandLineOptionsParser.new }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(parser.instance_variable_get(:@options_parser)).to_not be_nil
      end

      it "sets @options_parser to an instance of OptionParser" do
        expect(parser.instance_variable_get(:@options_parser)).to be_a(OptionParser)
      end

      it "defines @sorting_params" do
        expect(parser.instance_variable_get(:@sorting_params)).to_not be_nil
      end

      it "establishes @sorting_params as a Hash" do
        expect(parser.instance_variable_get(:@sorting_params)).to be_a(Hash)
      end
    end

    describe "#get_files" do
      context "when called with one file" do
        it "returns an array of the file" do
          expect(parser.get_files(argv)).to eql(["commas.txt"])
        end
      end

      context "when called with multiple files" do
        it "returns an array of all the files" do
          two_file_argv = ["commas.txt", "pipes.txt", "--sort", "-g"]
          expect(parser.get_files(two_file_argv)).to eql(["commas.txt", "pipes.txt"])
        end
      end
    end
  end
end