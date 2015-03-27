module Whammy
  class CommandLineInterface
    def initialize(argv)
      @options_parser = CommandLineOptionsParser.new
      @argv = argv
    end

    def display # TODO will call a Display class ?
    end

    def sort # TODO will call a Sort class ?
    end

    def parse_options(argv)
      # use OptionParser to separate argv into filenames and flags/options to pass to a Sorter class
    end
  end
end