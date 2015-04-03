module Whammy
  class CommandLineInterface
    def initialize(argv)
      @options_parser = CommandLineOptionsParser.new(argv)
    end

    def run!
      write_files!
      display(sorted)
    end

    def display(data)
      data.each do |record|
        puts record.values.map{ |str| str[0..6] }.join("\t\t")
      end
    end

    def sorted
      Sorter.new.sort!(sorting_params)
    end

    def sort_by
      @options_parser.sort_by
    end

    def files
      @options_parser.files
    end

    def write_files!
      Database.new.write_files(files)
    end
  end
end