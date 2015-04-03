module Whammy
  class Sorter
    def initialize
      @data = Database.new.read # will be master
    end

    def ladies_first
      @data.sort_by { |record| record[:gender] }
    end
  end
end