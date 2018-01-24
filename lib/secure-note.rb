require 'sinatra'
require 'secure-note/application'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite:SecureNote.db')

class Note
  include DataMapper::Resource

  property :uuid, Serial
  property :password, String, required: true
  property :title, String, required: true
  property :body, Text, required: true
  property :created_at, DateTime

end

DataMapper.finalize()
DataMapper.auto_upgrade!()
