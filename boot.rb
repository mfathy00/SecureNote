require "bundler/setup"

Bundler.require(:default, ENV["RACK_ENV"])

$: << File.expand_path("../", __FILE__)
