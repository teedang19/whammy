module Whammy
  class CommandLineOptionsParser

    def initialize
      @sorting_params = {}
      @options_parser = OptionParser.new do |opts|
        opts.on("--sort ENUM", ["-b", "-g", "-l"]) do |flag|
          case flag
          when "-b" then @sorting_params[:sort_by] = :birthday
          when "-g" then @sorting_params[:sort_by] = :gender
          when "-l" then @sorting_params[:sort_by] = :lastname
          end
        end
      end
    end

  end
end