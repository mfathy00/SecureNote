require "rack/test"
require "rspec"

ENV["RACK_ENV"] = "test"

require File.expand_path "../../boot.rb", __FILE__

require 'secure-note'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Rack::Test::Methods
  DataMapper.setup(:default, 'sqlite:SecureNotetest.db')
  DataMapper.finalize()
  DataMapper.auto_upgrade!()

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
        example.run
    end
  end

end
