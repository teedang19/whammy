require_relative "../spec_helper"

module Whammy
  describe Sorter do
    let(:sorter) { Sorter.new }

    describe "#initialize" do
      it "defines @data" do
        expect(sorter.instance_variable_get(:@data)).to_not be_nil
      end
    end
  end
end