require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:master_argv) { ["commas.txt", "--sort", "-b", "--master"] }
    let(:master_cli) { CommandLineInterface.new(master_argv) }
    let(:argv) { ["commas.txt", "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to_not be_nil
        expect(cli.instance_variable_get(:@options_parser)).to be_a(CommandLineOptionsParser)
      end

      it "defines @database" do
        expect(cli.instance_variable_get(:@database)).to_not be_nil
        expect(cli.instance_variable_get(:@database)).to be_a(Database)
      end
    end

    describe "#write_to_master?" do
      it "returns false when argv does not include '--master'" do
        expect(cli.write_to_master?).to be(false)
      end

      it "returns true when argv includes '--master'" do
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

    describe "#line_data" do
      it "returns an array of strings" do
        expect(cli.line_data).to be_a(Array)
        cli.line_data.each { |element| expect(element).to be_a(String) }
      end

      it "returns the lines of all the files" do
        expect(cli.line_data).to eql(["Govan Guthrie male blue 12/27/1971", "Schuldiner Chuck male orange 05/13/1967", "Reinhardt Django male green 01/23/1910"])
      end
    end

    describe "#write_data!" do
      context "when writing to master" do
        xit "writes line data to the master file" do
        end
      end

      context "when writing to a new file" do
        xit "writes line data to a new file" do
        end
      end
    end
  end
end