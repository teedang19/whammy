module Whammy
  class Parser
    DELIMITERS = [ /, /, / \| /, / / ]
    ATTRIBUTES = [ :last_name, :first_name, :gender, :favorite_color, :date_of_birth ]

    def line_data(files)
      files.map { |file| lineify(file) }.flatten
    end

    def lineify(file)
      split_lines(file).map { |values| values.join(" ") }
    end

    def parse(file)
      split_lines(file).map { |values| attributeify(values) }
    end

    # private # TODO should these methods be private?

    def split_lines(file)
      File.readlines(file).map { |line| split(line) }
    end

    def split(line)
      line.chomp.split(delimiter_of(line))
    end

    def delimiter_of(line)
      DELIMITERS.detect { |delimiter| line =~ delimiter }
    end

    def attributeify(values_arr)
      raise ArgumentError.new("There are records in your file with an incorrect number of attributes.") unless values_arr.count == ATTRIBUTES.count

      ATTRIBUTES.each_with_index.map { |attribute, index| [attribute, values_arr[index]] }.to_h
    end
  end
end