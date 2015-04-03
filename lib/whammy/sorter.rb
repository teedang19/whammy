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

    def last_name_ascending
      last_name_sort(:asc)
    end

    def last_name_descending
      last_name_sort(:desc)
    end

    private

    def last_name_sort(direction)
      case direction
      when :asc
        @data.sort { |record1, record2| record1[:last_name] <=> record2[:last_name] }
      when :desc
        @data.sort { |record1, record2| record2[:last_name] <=> record1[:last_name] }
      end
    end
  end
end