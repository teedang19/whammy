module Whammy
  class CommandLineInterface
    def initialize(argv)
      @options_parser = CommandLineOptionsParser.new(argv)
      @database = Database.new(write_to_master?)
    end

    def run!
      write_files!
      display(sorted_data)
      display_file_location
    end

    def display(data)
      data.each do |record|
        puts record.values.join("\t\t")
      end
    end

    def sorted_data
      Sorter.new(@database).sort!(sort_by)
    end

    def display_file_location
      puts "\n\nYour data is located at #{compiled_filename}."
    end

    def sort_by
      @options_parser.sort_by
    end

    def files
      @options_parser.files
    end

    def write_to_master?
      @options_parser.write_to_master
    end

    def write_files!
      @database.write_files(files)
    end

    def compiled_filename
      @database.data_filename
    end
  end
end