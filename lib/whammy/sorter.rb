require "date"

module Whammy
  class Sorter
    def initialize
      @data = Database.new.read # will be master
    end

    def sort!(method=nil)
      case method
      when :gender then ladies_first
      when :birthday then oldest_first
      when :last_name then last_name_descending
      else @data
      end
    end

    private

    def ladies_first
      @data.sort_by { |record| [record[:gender], record[:last_name]] }
    end

    def oldest_first
      @data.sort_by { |record| Date.strptime(record[:date_of_birth], '%m/%d/%Y') }
    end

    def last_name_descending
      @data.sort { |record1, record2| record2[:last_name] <=> record1[:last_name] }
    end
  end
end