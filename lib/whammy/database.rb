require "date"

module Whammy
  class Database
    MASTER_DB = "database.txt"

    def initialize(write_to_master)
      @filename = write_to_master ? MASTER_DB : DateTime.now.strftime("%m_%e_%y:%k_%M.txt")
    end
  end
end