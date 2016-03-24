require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///mylinks')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Link < ActiveRecord::Base
end


get '/' do
  @links = Link.order("id DESC")
  @comment_section= Link.order("id DESC")
  erb :index
end
 
get '/create' do
  erb :create
end

get '/about' do
  erb :about
end

post '/create' do
  link = Link.new(params[:link])
  if link.save
    redirect to "/"
  else
    return "failure!"
  end
end

post '/' do
  new_c = Link.new(params[:new_comment])
  if new_c.save
    redirect to "/"
  else
    return "Invalid"
  end
end

