module Whammy
  class CommandLineOptionsParser
    attr_reader :files, :sorting_params, :write_to_master

    def initialize(argv)
      @options_parser = OptionParser.new
      @argv = argv
      @files, @sorting_params, @write_to_master = parse_options!
    end

    def parse_options!
      sorting_params = nil
      write_to_master = false

      @options_parser.on("--sort ENUM", ["-b", "-g", "-l"]) do |flag|
        case flag
        when "-b" then sorting_params = :birthday
        when "-g" then sorting_params = :gender # TODO sort by gender is also last_name ascending. where does this logic go?
        when "-l" then sorting_params = :last_name
        end
      end
      
      @options_parser.on("--master") { write_to_master = true }

      files = @options_parser.parse(@argv)
      [files, sorting_params, write_to_master]

      rescue OptionParser::InvalidOption => e # TODO can we combine this error handling?
        puts "#{e.message}\nTry again!"
      rescue OptionParser::InvalidArgument => e
        puts "#{e.message}\nTry again!"
    end
  end
end