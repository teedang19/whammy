module Whammy
  class Parser

    def initialize(files_array) # TODO should a Parser only be initialized with one file?
      @files = files_array
    end

    def parse! # TODO should a Parser only be initialized with one file?
      @files.map { |file| parse_file(file) }
    end

    def parse_file(file)
    end
  end
end