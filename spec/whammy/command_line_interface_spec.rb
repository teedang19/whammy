require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }

    describe "#initialize" do
      it "should defined @option_parser" do
        expect(cli.instance_variable_get(:@option_parser)).to_not be_nil
        expect(cli.instance_variable_get(:@option_parser)).to be_a(OptionParser)
      end
    end

  end
end