module Whammy
  class CommandLineInterface
    def initialize(argv)
      @options_parser = CommandLineOptionsParser.new(argv)
      @database = Database.new(write_to_master?)
    end

    def run!
    end

    def display # TODO will call a Display class ?
    end

    def sort # TODO will call a Sort class ?
    end

    def write_to_master?
      @options_parser.write_to_master
    end

    def sorting_params
      @options_parser.sorting_params
    end

    def files
      @options_parser.files
    end

    def parsed_data
      Parser.new(files).parsed_data # TODO more tests?
    end

    def line_data
      Parser.new(files).line_data
    end

    def write_data!
      @database.write_data!(line_data)
    end

    def compiled_data_file
      @database.filename
    end
  end
end