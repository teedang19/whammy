require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:parser) { CommandLineOptionsParser.new(argv) }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(parser.instance_variable_get(:@options_parser)).to_not be_nil
      end

      it "sets @options_parser to an instance of OptionParser" do
        expect(parser.instance_variable_get(:@options_parser)).to be_a(OptionParser)
      end

      it "defines @sorting_params" do
        expect(parser.instance_variable_get(:@sorting_params)).to_not be_nil
        expect(parser.instance_variable_get(:@sorting_params)).to be_a(Hash)
      end

      it "defines @files" do
        expect(parser.instance_variable_get(:@files)).to_not be_nil
        expect(parser.instance_variable_get(:@files)).to be_a(Array)
      end

      it "defines @write_to_master" do
        expect(parser.instance_variable_get(:@write_to_master)).to_not be_nil
      end
    end

    describe "#parse_options!" do
      it "returns an array" do
        expect(parser.parse_options!).to be_a(Array)
      end

      it "separates the files from the passed-in options" do
        expect(parser.parse_options![0]).to eql(["commas.txt"])
      end

      it "can separate more than one file" do
        multiple_file_argv = ["commas.txt", "pipes.txt", "--sort", "-g"]
        multiple_file_parser = CommandLineOptionsParser.new(multiple_file_argv)
        expect(multiple_file_parser.parse_options![0]).to eql(["commas.txt", "pipes.txt"])
      end

      it "separates the sorting params from the passed-in options" do
        expect(parser.parse_options![1]).to have_key(:sort_by)
      end

      it "returns the correct sorting params for birthday" do
        expect(parser.parse_options![1]).to eql({ sort_by: :birthday })
      end

      it "returns the correct sorting params for gender" do
        gender_argv = ["commas.txt", "--sort", "-g"]
        gender_parser = CommandLineOptionsParser.new(gender_argv)
        expect(gender_parser.parse_options![1]).to eql({ sort_by: :gender })
      end

      it "returns the correct sorting params for birthday" do
        last_name_argv = ["commas.txt", "--sort", "-l"]
        last_name_parser = CommandLineOptionsParser.new(last_name_argv)
        expect(last_name_parser.parse_options![1]).to eql({ sort_by: :last_name })
      end

      it "separates write_to_master from the passed-in options" do
        expect(parser.parse_options![2]).to_not be_nil
      end

      it "sets write_to_master to false when --master is not passed in" do
        expect(parser.parse_options![2]).to be(false)
      end

      it "sets write_to_master to true when --master is passed in" do
        master_args = ["commas.txt", "--sort", "-b", "--master"]
        master_parser = CommandLineOptionsParser.new(master_args)
        expect(master_parser.parse_options![2]).to be(true)
      end

      def capture_stdout(&block)
        original_stdout = $stdout
        $stdout = fake = StringIO.new
        begin
          yield
        ensure
          $stdout = original_stdout
        end
        fake.string
      end

      context "with invalid options" do
        it "rescues the error with a message" do
          invalid_options = ["commas.txt", "--poop", "-g"]
          invalid_parser = CommandLineOptionsParser.new(invalid_options)
          output = capture_stdout { invalid_parser.parse_options! }
          expect(output).to eql("invalid option: --poop\nTry again!\n")
        end
      end

      context "with invalid arguments to the options" do
        it "rescues the error with a message" do
          invalid_args = ["commas.txt", "--sort", "-x"]
          invalid_arg_parser = CommandLineOptionsParser.new(invalid_args)
          output = capture_stdout { invalid_arg_parser.parse_options! }
          expect(output).to eql("invalid argument: --sort -x\nTry again!\n")
        end
      end
    end
  end
end