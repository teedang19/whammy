require_relative "../spec_helper"

module Whammy
  describe CommandLineOptionsParser do
    let(:file) { "spec/fixtures/files/commas.txt" }
    let(:argv) { [file, "--sort", "-b"] }
    let(:parser) { CommandLineOptionsParser.new(argv) }

    describe "#parse_options!" do
      it "returns an array" do
        expect(parser.parse_options!).to be_a(Array)
      end

      context "file options" do
        it "separates the files from other options" do
          expect(parser.parse_options![0]).to eql(["spec/fixtures/files/commas.txt"])
        end

        it "separates more than one file" do
          multiple_file_argv = ["spec/fixtures/files/commas.txt", "spec/fixtures/files/pipes.txt", "--sort", "-g"]
          multiple_file_parser = CommandLineOptionsParser.new(multiple_file_argv)
          expect(multiple_file_parser.parse_options![0]).to eql(["spec/fixtures/files/commas.txt", "spec/fixtures/files/pipes.txt"])
        end
      end

      context "sorting params" do
        it "separates the sorting params from other options" do
          expect(parser.parse_options![1]).to be_a(Symbol)
          expect(parser.parse_options![1]).to eql(:birthdate)
        end

        context "by birthdate" do
          it "returns the correct params" do
            expect(parser.parse_options![1]).to eql(:birthdate)
          end
        end

        context "by gender" do
          it "returns the correct params" do
            gender_argv = ["spec/fixtures/files/commas.txt", "--sort", "-g"]
            gender_parser = CommandLineOptionsParser.new(gender_argv)
            expect(gender_parser.parse_options![1]).to eql(:gender)
          end
        end

        context "by last_name" do
          it "returns the correct params" do
            last_name_argv = ["spec/fixtures/files/commas.txt", "--sort", "-l"]
            last_name_parser = CommandLineOptionsParser.new(last_name_argv)
            expect(last_name_parser.parse_options![1]).to eql(:last_name)
          end
        end

        context "no sorting params" do
          it "returns nil for sorting params" do
            sortless_argv = ["spec/fixtures/files/commas.txt"]
            sortless_parser = CommandLineOptionsParser.new(sortless_argv)
            expect(sortless_parser.parse_options![1]).to eql(nil)
          end
        end
      end

      context "write_to_master" do
        it "separates write_to_master from other options" do
          expect(parser.parse_options![2]).to_not be_nil
        end

        context "--master is NOT passed in" do
          it "returns false" do
            expect(parser.parse_options![2]).to be(false)
          end
        end

        context "--master is passed in" do
          it "returns true" do
            master_args = ["spec/fixtures/files/commas.txt", "--sort", "-b", "--master"]
            master_parser = CommandLineOptionsParser.new(master_args)
            expect(master_parser.parse_options![2]).to be(true)
          end
        end

        context "with no sorting params" do
          context "--master is passed in" do
            it "is still set" do
              sortless_master_argv = ["spec/fixtures/files/commas.txt", "--master"]
              sortless_master_parser = CommandLineOptionsParser.new(sortless_master_argv)
              expect(sortless_master_parser.parse_options![2]).to eql(true)
            end
          end

          context "--master is NOT passed in" do
            it "is still set" do
              sortless_argv = ["spec/fixtures/files/commas.txt"]
              sortless_parser = CommandLineOptionsParser.new(sortless_argv)
              expect(sortless_parser.parse_options![2]).to eql(false)
            end
          end
        end
      end

      context "with invalid options" do
        it "rescues the error with a message" do
          invalid_options = ["spec/fixtures/files/commas.txt", "--poop", "-g"]
          invalid_parser = CommandLineOptionsParser.new(invalid_options)
          expect{ invalid_parser.parse_options! }.to output("invalid option: --poop\nTry again!\n").to_stdout
        end
      end

      context "with invalid arguments to the options" do
        it "rescues the error with a message" do
          invalid_args = ["spec/fixtures/files/commas.txt", "--sort", "-x"]
          invalid_arg_parser = CommandLineOptionsParser.new(invalid_args)
          expect{ invalid_arg_parser.parse_options! }.to output("invalid argument: --sort -x\nTry again!\n").to_stdout
        end
      end
    end
  end
end