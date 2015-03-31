require_relative "../spec_helper"

module Whammy
  describe Database do
    let(:master_db) { Database.new(true) }
    let(:temp_db) { Database.new(false) }

    describe "#initialize" do
      context "when writing to master" do
        it "defines @filename" do
          expect(master_db.instance_variable_get(:@filename)).to_not be_nil
        end

        it "sets @filename to the master db" do
          expect(master_db.instance_variable_get(:@filename)).to eql("database.txt")
        end
      end

      context "when writing to a new file" do
        it "defines @filename" do
          expect(temp_db.instance_variable_get(:@filename)).to_not be_nil
        end

        it "sets @filename to a Timestamp string" do
          expect(temp_db.instance_variable_get(:@filename)).to eql(DateTime.now.strftime("%m_%e_%y:%k_%M.txt"))
        end
      end
    end
  end
end