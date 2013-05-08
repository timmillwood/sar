require 'sinatra'
require 'sinatra/activerecord'

db = URI.parse('')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Note < ActiveRecord::Base
end

get "/" do
  @notes = Note.order("created_at DESC")
  redirect "/new" if @notes.empty?
  erb :index
end

get "/new" do
  erb :new
end

post "/new" do
  @note = Note.new(params[:note])
  if @note.save
    redirect "note/#{@note.id}"
  else
    erb :new
  end
end

get "/note/:id" do
  @note = Note.find_by_id(params[:id])
  erb :note
end
