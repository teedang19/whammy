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

    describe "#sorting_params" do
      context "when called with params" do
        it "returns the correct params for birthday" do
          parser.instance_variable_get(:@options_parser).parse(argv) # must be called to pass in the ARGV
          expect(parser.sorting_params).to eql({ sort_by: :birthday })
        end

        it "returns the correct params for gender" do
          gender_argv = ["commas.txt", "--sort", "-g"]
          parser.instance_variable_get(:@options_parser).parse(gender_argv)
          expect(parser.sorting_params).to eql({ sort_by: :gender })
        end

        it "returns the correct params for last name" do
          last_name_argv = ["commas.txt", "--sort", "-l"]
          parser.instance_variable_get(:@options_parser).parse(last_name_argv)
          expect(parser.sorting_params).to eql({ sort_by: :last_name })
        end
      end

      context "when called without sorting params" do
        it "returns an empty hash" do
          no_sort_argv = ["commas.txt", "pipes.txt"]
          parser.instance_variable_get(:@options_parser).parse(no_sort_argv)
          expect(parser.sorting_params).to eql( {} )
        end
      end
    end
  end
end