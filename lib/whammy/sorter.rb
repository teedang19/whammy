module Whammy
  class Sorter
    def initialize
      @data = Database.new.read # will be master
    end
  end
end