module Whammy
  class Database
    MASTER_DB = "database.txt"

    def initialize
      @filename = MASTER_DB
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