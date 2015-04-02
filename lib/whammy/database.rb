require "date"

module Whammy
  class Database
    MASTER_DB = "database.txt"

    def initialize(write_to_master)
      @filename = write_to_master ? MASTER_DB : DateTime.now.strftime("%m_%e_%y:%k_%M.txt")
    end

    def data_dir
      "data/"
    end

    def filename
      "#{data_dir}#{@filename}"
    end

    def write!(line_data)
      File.open(filename, "a") do |file|
        line_data.map { |line| file.puts(line) }
      end
    end
  end
end