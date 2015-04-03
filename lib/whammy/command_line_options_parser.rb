module Whammy
  class CommandLineOptionsParser
    attr_reader :files, :sort_by, :write_to_master

    def initialize(argv)
      @options_parser = OptionParser.new
      @argv = argv
      @files, @sort_by, @write_to_master = parse_options!
    end

    def parse_options!
      sort_by = nil
      write_to_master = false # TODO remove or implement

      @options_parser.on("--sort ENUM", ["-b", "-g", "-l"]) do |flag|
        case flag
        when "-b" then sort_by = :birthday
        when "-g" then sort_by = :gender
        when "-l" then sort_by = :last_name
        end
      end
      
      @options_parser.on("--master") { write_to_master = true }

      files = @options_parser.parse(@argv)
      [files, sort_by, write_to_master]

      rescue OptionParser::InvalidOption => e # TODO can we combine this error handling?
        puts "#{e.message}\nTry again!"
      rescue OptionParser::InvalidArgument => e
        puts "#{e.message}\nTry again!"
    end
  end
end