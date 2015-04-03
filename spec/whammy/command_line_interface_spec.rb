require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:master_argv) { ["commas.txt", "--sort", "-b", "--master"] }
    let(:master_cli) { CommandLineInterface.new(master_argv) }
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }
    let(:compiled_filename) { "data/#{DateTime.now.strftime("%m_%e_%y:%k_%M.txt")}" }

    before(:each) do
      allow_any_instance_of(Database).to receive(:data_file).and_return("data/test.txt")
    end

    after(:each) do
      File.open("data/test.txt", "w") {}
    end

    describe "#initialize" do
      it "defines @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to_not be_nil
      end

      it "sets @options_parser to a CommandLineOptionsParser" do
        expect(cli.instance_variable_get(:@options_parser)).to be_a(CommandLineOptionsParser)
      end
    end

    describe "#run!" do
      xit "TODO" do
      end
    end

    describe "#display" do
      xit "TODO" do
      end
    end

    describe "#sorted_data" do
      it "returns an array" do
        expect(cli.sorted_data).to be_a(Array)
      end

      it "returns an array of hash data" do
        cli.sorted_data.each do |element|
          expect(element).to be_a(Hash)
        end
      end

      context "no sorting" do
        xit "returns the data from the database" do
        end
      end
      context "gender" do
        xit "TODO" do
        end
      end
      context "last_name" do
        xit "TODO" do
        end
      end
      context "birthday" do
        xit "TODO" do
        end
      end
    end   

    describe "#sort_by" do
      it "returns the correct sorting params for birthday" do
        expect(cli.sort_by).to eql(:birthday)
      end

      it "returns the correct sorting params for gender" do
        gender_argv = ["commas.txt", "--sort", "-g"]
        gender_cli = CommandLineInterface.new(gender_argv)
        expect(gender_cli.sort_by).to eql(:gender)
      end

      it "returns the correct sorting params for last_name" do
        last_name_argv = ["commas.txt", "--sort", "-l"]
        last_name_cli = CommandLineInterface.new(last_name_argv)
        expect(last_name_cli.sort_by).to eql(:last_name)
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
      it "writes line data to a new file" do
        cli.write_files!
        expect(File.read("data/test.txt")).to include("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\nReinhardt Django male green 01/23/1910")
      end
    end
  end
end