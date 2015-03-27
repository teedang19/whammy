module Whammy
  class CommandLineOptionsParser
    def initialize
      @sorting_params = {}
      @options_parser = OptionParser.new do |opts|
        opts.on("--sort ENUM", ["-b", "-g", "-l"]) do |flag|
          case flag
          when "-b" then @sorting_params[:sort_by] = :birthday
          when "-g" then @sorting_params[:sort_by] = :gender # TODO sort by gender is also last_name ascending. where does this logic go?
          when "-l" then @sorting_params[:sort_by] = :last_name
          end
        end
      end
    end

    def get_files(argv)
      @options_parser.parse(argv)
      rescue OptionParser::InvalidOption => e # TODO can we combine this error handling?
        puts "#{e.message}\nTry again!"
      rescue OptionParser::InvalidArgument => e
        puts "#{e.message}\nTry again!"
    end

    def sorting_params
      @sorting_params
    end
  end
end