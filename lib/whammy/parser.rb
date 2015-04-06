module Whammy
  class Parser
    DELIMITERS = [ /, /, / \| /, / / ]
    ATTRIBUTES = [ :last_name, :first_name, :gender, :favorite_color, :date_of_birth ]

    def parse_file(file)
      split_lines(file).map { |values| set_attributes(values) }
    end

    def parse_entry(entry)
      return ordered_attributes(entry) if valid_entry?(entry)
      set_attributes split(entry)
    end

    # private # TODO should these methods be private?

    def valid_entry?(entry)
      entry.is_a?(Hash) && all_values_present?(entry)
    end

    def all_values_present?(entry)
      raise ArgumentError.new("ERROR: Missing attributes.") unless ATTRIBUTES.all? { |attribute| entry.has_key?(attribute) }
      true
    end

    def ordered_attributes(entry)
      ATTRIBUTES.map { |attribute| [attribute, entry[attribute]] }.to_h
    end

    def split_lines(file)
      File.readlines(file).map { |line| split(line) }
    end

    def split(line)
      line.chomp.split delimiter_of(line)
    end

    def delimiter_of(line)
      DELIMITERS.detect { |delimiter| line =~ delimiter }
    end

    def set_attributes(values_arr)
      raise ArgumentError.new("ERROR: Incorrect number of attributes.") unless values_arr.count == ATTRIBUTES.count

      ATTRIBUTES.each_with_index.map { |attribute, index| [attribute, values_arr[index]] }.to_h
    end
  end
end