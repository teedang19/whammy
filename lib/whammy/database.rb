require "date"

module Whammy
  class Database
    MASTER_DB = "database.txt"

    def initialize(use_master = true)
      @filename = use_master ? MASTER_DB : DateTime.now.strftime("%m_%d_%y:%k_%M.txt")
      @parser = Parser.new
    end

    def data_dir
      "data/"
    end

    def data_file
      "#{data_dir}#{@filename}"
    end

    def read
      @parser.parse_file(data_file)
    end

    def write_files(files)
      files.each { |file| write_file(file) }
    end

    def write_file(file)
      File.foreach(file) { |line| write_line(line) }
    end

    def write_line(entry)
      record = get_data(entry)
      File.open(data_file, "a") do |file|
        file.puts normalize(record)
      end
      record
    end

    private

    def get_data(entry)
      @parser.parse_entry(entry)
    end

    def normalize(record) # defines a format consistency for records to be written
      record.values.join(" ")
    end
  end
end