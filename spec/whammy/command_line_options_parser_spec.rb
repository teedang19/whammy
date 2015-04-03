require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:parser) { CommandLineOptionsParser.new(argv) }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(parser.instance_variable_get(:@options_parser)).to_not be_nil
      end

      it "sets @options_parser to an OptionParser" do
        expect(parser.instance_variable_get(:@options_parser)).to be_a(OptionParser)
      end

      it "defines @sort_by" do
        expect(parser.instance_variable_get(:@sort_by)).to_not be_nil
        expect(parser.instance_variable_get(:@sort_by)).to be_a(Symbol)
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

      context "file options" do
        it "separates the files from the other options" do
          expect(parser.parse_options![0]).to eql(["commas.txt"])
        end

        it "can separate more than one file" do
          multiple_file_argv = ["commas.txt", "pipes.txt", "--sort", "-g"]
          multiple_file_parser = CommandLineOptionsParser.new(multiple_file_argv)
          expect(multiple_file_parser.parse_options![0]).to eql(["commas.txt", "pipes.txt"])
        end
      end

      context "sorting params" do
        it "separates the sorting params from the other options" do
          expect(parser.parse_options![1]).to be_a(Symbol)
        end

        context "by birthday" do
          it "returns the correct params for birthday" do
            expect(parser.parse_options![1]).to eql(:birthday)
          end
        end

        context "by gender" do
          it "returns the correct params for gender" do
            gender_argv = ["commas.txt", "--sort", "-g"]
            gender_parser = CommandLineOptionsParser.new(gender_argv)
            expect(gender_parser.parse_options![1]).to eql(:gender)
          end
        end

        context "by last_name" do
          it "returns the correct params for last_name" do
            last_name_argv = ["commas.txt", "--sort", "-l"]
            last_name_parser = CommandLineOptionsParser.new(last_name_argv)
            expect(last_name_parser.parse_options![1]).to eql(:last_name)
          end
        end

        context "no sorting params" do
          it "returns nil for sorting params when none are present" do
            sortless_argv = ["commas.txt"]
            sortless_parser = CommandLineOptionsParser.new(sortless_argv)
            expect(sortless_parser.parse_options![1]).to eql(nil)
          end
        end
      end

      context "write_to_master" do
        it "separates write_to_master from the other options" do
          expect(parser.parse_options![2]).to_not be_nil
        end

        context "--master is NOT passed in" do
          it "sets write_to_master to false" do
            expect(parser.parse_options![2]).to be(false)
          end
        end

        context "--master is passed in" do
          it "sets write_to_master to true when --master is passed in" do
            master_args = ["commas.txt", "--sort", "-b", "--master"]
            master_parser = CommandLineOptionsParser.new(master_args)
            expect(master_parser.parse_options![2]).to be(true)
          end
        end

        context "with no sorting params" do
          context "--master is passed in" do
            it "is still set" do
              sortless_master_argv = ["commas.txt", "--master"]
              sortless_master_parser = CommandLineOptionsParser.new(sortless_master_argv)
              expect(sortless_master_parser.parse_options![2]).to eql(true)
            end
          end

          context "--master is NOT passed in" do
            it "is still set" do
              sortless_argv = ["commas.txt"]
              sortless_parser = CommandLineOptionsParser.new(sortless_argv)
              expect(sortless_parser.parse_options![2]).to eql(false)
            end
          end
        end
      end

      context "with invalid options" do
        it "rescues the error with a message" do
          invalid_options = ["commas.txt", "--poop", "-g"]
          invalid_parser = CommandLineOptionsParser.new(invalid_options)
          expect{ invalid_parser.parse_options! }.to output("invalid option: --poop\nTry again!\n").to_stdout
        end
      end

      context "with invalid arguments to the options" do
        it "rescues the error with a message" do
          invalid_args = ["commas.txt", "--sort", "-x"]
          invalid_arg_parser = CommandLineOptionsParser.new(invalid_args)
          expect{ invalid_arg_parser.parse_options! }.to output("invalid argument: --sort -x\nTry again!\n").to_stdout
        end
      end
    end
  end
end