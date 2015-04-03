module Whammy
  class Parser
    DELIMITERS = [ /, /, / \| /, / / ]
    ATTRIBUTES = [ :last_name, :first_name, :gender, :favorite_color, :date_of_birth ]

    def line_data(files)
      files.map { |file| lineify(file) }.flatten
    end

    def lineify(file)
      File.readlines(file).map { |line| split_line!(line).join(" ") }
    end

    def parse_file!(file)
      File.readlines(file).map { |line| parse_line!(line) }
    end

    def parse_line!(line)
      values_arr = split_line!(line)
      attributeify(values_arr)
    end

    def split_line!(line)
      line.chomp.split(delimiter(line))
    end

    def delimiter(line)
      DELIMITERS.detect { |delimiter| line =~ delimiter }
    end

    def attributeify(values_arr)
      raise ArgumentError.new("There are records in your file with an incorrect number of attributes.") unless values_arr.count == ATTRIBUTES.count

      ATTRIBUTES.each_with_index.map { |attribute, index| [attribute, values_arr[index]] }.to_h
    end
  end
end