require 'sinatra/base'
require "json"
require "pry"
require 'base64'

class Application < Sinatra::Base
  before do
    content_type :json
  end
  # Note creation
  post '/secure-note' do
    note = Note.new
    note.password = Base64.encode64(params[:password])
    note.body = Base64.encode64(params[:body])
    note.title = Base64.encode64(params[:title])
    note.save
    if note.saved?
      [201, note.to_json(only: :uuid)]
    else
      [400, "Please check your data".to_json]
    end
  end
  # Note Update
  put '/secure-note/:uuid' do
    note = Note.get(params[:uuid])
    if Base64.decode64(note.password) == params[:password]
      note.body = Base64.encode64(params[:body])
      note.title = Base64.encode64(params[:title])
      note.save
      [200, note.to_json(only: :uuid)]
    else
      [401, "Wrong password".to_json]
    end
  end
  # Note Delete
  delete '/secure-note/:uuid' do
      note = Note.get(params[:uuid])
      if  Base64.decode64(note.password) == params[:password]
        Note.get(params[:uuid]).destroy
        [204, "Note delete".to_json]
      else
        [401, "Wrong password".to_json]
      end
  end
  # Note retrieval
  get '/secure-note/:uuid' do
    note = Note.get(params[:uuid])
    if  Base64.decode64(note.password) == params[:password]
        note.body = Base64.decode64(note.body)
        note.title = Base64.decode64(note.title)
      [202 , note.to_json(only: [:uuid, :body, :title])]
    else
      [401, "Wrong password".to_json]
    end
  end
end
