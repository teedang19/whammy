module Whammy
  class Database
    MASTER_DB = "database.txt"

    def initialize
      @filename = MASTER_DB
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
      lines = @parser.line_data(files)
      write_lines(lines)
    end

    def write_lines(lines)
      File.open(data_file, "a") do |file|
        lines.each { |line| file.puts(line) }
      end
    end
  end
end