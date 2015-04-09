require 'simplecov'
SimpleCov.start

require_relative "../lib/whammy"
require "rspec"

RSpec.configure do |config|
  config.before do
    $stdout = StringIO.new
  end
  config.after(:all) do
    $stdout = STDOUT
  end
end