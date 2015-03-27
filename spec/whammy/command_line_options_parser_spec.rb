require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:argv) { ["commas.txt", "-b"] }
    let(:parser) { CommandLineOptionsParser.new }

    describe "#initialize" do
      it "should define @options_parser" do
        expect(parser.instance_variable_get(:@options_parser)).to_not be_nil
      end

      it "should set @options_parser to an instance of OptionParser" do
        expect(parser.instance_variable_get(:@options_parser)).to be_a(OptionParser)
      end
    end
  end
end