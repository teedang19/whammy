require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to_not be_nil
        expect(cli.instance_variable_get(:@options_parser)).to be_a(CommandLineOptionsParser)
      end
    end

    describe "#write_to_master?" do
      it "returns false when argv does not include '--master'" do
        expect(cli.write_to_master?).to be(false)
      end

      it "returns true when argv includes '--master'" do
        master_argv = ["commas.txt", "--sort", "-b", "--master"]
        master_cli = CommandLineInterface.new(master_argv)
        expect(master_cli.write_to_master?).to be(true)
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

    describe "#parsed_data" do
      it "returns the correctly parsed data" do
        expect(cli.parsed_data).to eql([{last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
      end
    end
  end
end