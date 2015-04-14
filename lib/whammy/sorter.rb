require "date"

module Whammy
  class Sorter
    def initialize(database = nil)
      @data = database ? database.read : Database.new.read # will be master
    end

    def sort!(method = nil)
      case method # method.try(:to_sym) -- RAILS ONLY
      when :gender then ladies_first
      when :birthdate then oldest_first
      when :last_name then last_name_descending
      else data
      end
    end

    private

    attr_reader :data

    def ladies_first
      data.sort_by { |record| [record[:gender], record[:last_name]] }
    end

    def oldest_first
      data.sort_by { |record| Date.strptime(record[:date_of_birth], '%m/%d/%Y') }
    end

    def last_name_descending
      data.sort { |record1, record2| record2[:last_name] <=> record1[:last_name] }
    end
  end
end