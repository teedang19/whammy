module Whammy
  class CommandLineInterface
    def initialize(argv)
      @options_parser = CommandLineOptionsParser.new(argv)
    end

    def run!
    end

    def display # TODO will call a Display class ?
    end

    def sort # TODO will call a Sort class ?
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

    def write_to_file # TODO what will this look like?
    end
  end
end