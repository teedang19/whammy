require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:argv) { ["commas.txt", "-b"] }
    let(:parser) { CommandLineOptionsParser.new }

    describe "#initialize" do
      it "should defined @options_parser" do
        expect(parser.instance_variable_get(:@options_parser)).to_not be_nil
      end
    end
  end
end