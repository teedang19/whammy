require_relative "../spec_helper"

module Whammy
  describe CommandLineInterface do
    let(:file) { "spec/fixtures/files/commas.txt" }

    let(:master_argv) { [file, "--sort", "-b", "--master"] }
    let(:master_cli) { CommandLineInterface.new(master_argv) }

    let(:argv) { [file, "--sort", "-b"] }
    let(:cli)  { CommandLineInterface.new(argv) }

    describe "#initialize" do
      it "defines @options_parser" do
        expect(cli.instance_variable_get(:@options_parser)).to_not be_nil
      end
      it "sets @options_parser to a CommandLineOptionsParser" do
        expect(cli.instance_variable_get(:@options_parser)).to be_a(CommandLineOptionsParser)
      end

      it "defines @database" do
        expect(cli.instance_variable_get(:@database)).to_not be_nil
      end

      it "sets @database to be a Database" do
        expect(cli.instance_variable_get(:@database)).to be_a(Database)
      end
    end

    describe "#run!" do
      let(:test_database) { "spec/fixtures/files/test_db.txt" }

      before do
        allow_any_instance_of(Database).to receive(:data_file).and_return(test_database)
      end

      after do
        File.open(test_database, "w") {}
      end

      it "calls #write_files!" do
        expect(cli).to receive(:write_files!).exactly(1).times
        cli.run!
      end
      it "calls #display" do
        expect(cli).to receive(:display).exactly(1).times
        cli.run!
      end

      it "calls #display_file_location" do
        expect(cli).to receive(:display_file_location).exactly(1).times
        cli.run!
      end
    end

    describe "#display" do
      let(:data) { [ { last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971" } ] }

      it "outputs the data to stdout" do
        expect{cli.display(data)}.to output("Govan\t\tGuthrie\t\tmale\t\tblue\t\t12/27/1971\n").to_stdout
      end
    end

    describe "#sorted_data" do
      let(:example_db) { "spec/fixtures/files/example_db.txt" }

      before(:each) do
        allow_any_instance_of(Database).to receive(:data_file).and_return(example_db)
      end

      it "returns an array" do
        expect(cli.sorted_data).to be_a(Array)
      end

      it "returns an array of hashes" do
        cli.sorted_data.each do |element|
          expect(element).to be_a(Hash)
        end
      end

      context "no sorting" do
        no_sort_argv = ["spec/fixtures/files/commas.txt"]
        no_sort_cli = CommandLineInterface.new(no_sort_cli)

        it "returns the data" do
          expect(no_sort_cli.sorted_data).to eql([{last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
        end
      end

      context "gender" do
        gender_argv = ["--sort", "-g"]
        gender_cli = CommandLineInterface.new(gender_argv)

        it "returns data sorted by gender & last name asc" do
          expect(gender_cli.sorted_data).to eql([{last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}])
        end
      end

      context "last_name" do
        last_name_argv = ["--sort", "-l"]
        last_name_cli = CommandLineInterface.new(last_name_argv)

        it "returns data sorted by last name desc" do
          expect(last_name_cli.sorted_data).to eql([{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
        end
      end

      context "birthdate" do
        birthdate_argv = ["--sort", "-b"]
        birthdate_cli = CommandLineInterface.new(birthdate_argv)

        it "returns data sorted by birthdate asc" do
          expect(birthdate_cli.sorted_data).to eql([{last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}])
        end
      end
    end

    describe "#display_file_location" do
      let(:example_db) { "spec/fixtures/files/example_db.txt" }

      before(:each) do
        allow_any_instance_of(Database).to receive(:data_file).and_return(example_db)
      end

      it "outputs the filename of the compiled data" do
        expect{cli.display_file_location}.to output("\n\nYour data is located at #{example_db}.\n").to_stdout
      end
    end

    describe "#sort_by" do
      context "birthdate" do
        it "returns the correct symbol" do
          expect(cli.sort_by).to eql(:birthdate)
        end
      end

      context "gender" do
        gender_argv = ["--sort", "-g"]
        gender_cli = CommandLineInterface.new(gender_argv)

        it "returns the symbol for gender" do
          expect(gender_cli.sort_by).to eql(:gender)
        end
      end

      context "last_name" do
        last_name_argv = ["--sort", "-l"]
        last_name_cli = CommandLineInterface.new(last_name_argv)

        it "returns the symbol for last_name" do
          expect(last_name_cli.sort_by).to eql(:last_name)
        end
      end
    end

    describe "#files" do
      context "with one file" do
        it "returns an array of the file" do
          expect(cli.files).to eql(["spec/fixtures/files/commas.txt"])
        end
      end

      context "with multiple files" do
        multiple_files_argv = ["spec/fixtures/files/commas.txt", "spec/fixtures/files/pipes.txt", "--sort", "-b"]
        multiple_cli = CommandLineInterface.new(multiple_files_argv)
        
        it "returns an array of all the files" do
          expect(multiple_cli.files).to eql(["spec/fixtures/files/commas.txt", "spec/fixtures/files/pipes.txt"])
        end
      end
    end

    describe "#write_to_master" do
      context "when writing to master" do
        it "returns true" do
          expect(master_cli.write_to_master?).to eql(true)
        end
      end

      context "when writing to a new file" do
        it "returns false" do
          expect(cli.write_to_master?).to eql(false)
        end
      end
    end

    describe "#write_files!" do
      let(:test_database) { "spec/fixtures/files/test_db.txt" }

      before do
        allow_any_instance_of(Database).to receive(:data_file).and_return(test_database)
      end

      after do
        File.open(test_database, "w") {}
      end

      it "writes the file's records to the db" do
        cli.write_files!
        expect(File.read(test_database)).to eql("Govan Guthrie male blue 12/27/1971\nSchuldiner Chuck male orange 05/13/1967\nReinhardt Django male green 01/23/1910\n")
      end
    end

    describe "#compiled_filename" do
      let(:example_db) { "spec/fixtures/files/example_db.txt" }

      before(:each) do
        allow_any_instance_of(Database).to receive(:data_file).and_return(example_db)
      end

      it "returns the filename of the data" do
        expect(cli.compiled_filename).to eql(example_db)
      end
    end
  end
end