module Whammy
  class Parser
    DELIMITERS = [/, /, / \| /, / /]

    def initialize(files_array) # TODO should a Parser only be initialized with one file?
      @files = files_array
    end

    def parse! # TODO should a Parser only be initialized with one file?
      @files.map { |file| parse_file(file) }
    end

    def parse_file(file)
      File.readlines(file).map { |line| split_line(line) }
    end

    def split_line(line)
      line.chomp.split(delimiter(line))
    end

    def delimiter(line)
      DELIMITERS.detect { |delimiter| line =~ delimiter }
    end
  end
end