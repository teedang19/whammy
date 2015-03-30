require_relative "../spec_helper"

module Whammy
  describe Parser do
    let(:files) { ["commas.txt", "pipes.txt"] }
    let(:parser) { Parser.new(files) }
  end
end