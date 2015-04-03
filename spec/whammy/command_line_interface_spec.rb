require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:master_argv) { ["commas.txt", "--sort", "-b", "--master"] }
    let(:master_cli) { CommandLineInterface.new(master_argv) }
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }
    let(:compiled_filename) { "data/#{DateTime.now.strftime("%m_%e_%y:%k_%M.txt")}" }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to_not be_nil
        expect(cli.instance_variable_get(:@options_parser)).to be_a(CommandLineOptionsParser)
      end
    end

    describe "#sorting_params" do
      it "delegates the retrieval of sorting_params to @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to receive(:sorting_params)
        cli.sorting_params
      end

      it "returns the correct sorting params for birthday" do
        expect(cli.sorting_params).to eql({ sort_by: :birthday })
      end

      it "returns the correct sorting params for gender" do
        gender_argv = ["commas.txt", "--sort", "-g"]
        gender_cli = CommandLineInterface.new(gender_argv)
        expect(gender_cli.sorting_params).to eql({ sort_by: :gender })
      end

      it "returns the correct sorting params for last_name" do
        last_name_argv = ["commas.txt", "--sort", "-l"]
        last_name_cli = CommandLineInterface.new(last_name_argv)
        expect(last_name_cli.sorting_params).to eql({ sort_by: :last_name })
      end
    end

    describe "#files" do
      it "delegates the retrieval of files to @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to receive(:files)
        cli.files
      end

      context "when the parser is called with one file" do
        it "returns an array of the file" do
          expect(cli.files).to eql(["commas.txt"])
        end
      end

      context "when the parser is called with multiple files" do
        it "returns an array of all the files" do
          multiple_files_argv = ["commas.txt", "pipes.txt", "--sort", "-b"]
          cli = CommandLineInterface.new(multiple_files_argv)
          expect(cli.files).to eql(["commas.txt", "pipes.txt"])
        end
      end
    end

    describe "#write_files!" do
      # TODO database cleaner; allow any instance of database to receive filename and return a different name, os that we aren't calling the same file -- and we can clean out the file after every test run; remove hardcoding of db file
      it "writes line data to a new file" do
        cli.write_files!
        expect(File.read("data/database.txt")).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\nReinhardt Django male green 01/23/1910")
      end
    end
  end
end