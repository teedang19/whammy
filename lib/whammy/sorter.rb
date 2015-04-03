require "date"

module Whammy
  class Sorter
    def initialize
      @data = Database.new.read # will be master
    end

    def ladies_first
      @data.sort_by { |record| record[:gender] }
    end

    def oldest_first
      @data.sort_by { |record| Date.strptime(record[:date_of_birth], '%m/%d/%Y') }
    end
  end
end