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
  has_many :comments  
  validates_presence_of :author
  validates_uniqueness_of :link
  validates_presence_of :comment
end

class Comment < ActiveRecord::Base
  belongs_to :links
  validates_presence_of :comment
  validates_presence_of :author
end


get '/' do
  @links = Link.order("id DESC")
  erb :index
end

get "/about" do
  erb :about
end
 
get '/create' do
  erb :create
end

get '/add_comment' do
  erb :comment
end

get '/error' do
  erb :error
end


post '/create' do
  link = Link.new(params[:link])
  if link.save
    redirect to "/"
  else
     redirect to "/error"
  end
end

post '/add_comment' do
  comment = Comment.new(params[:comment])
  if comment.save
    redirect to "/"
  else
     redirect to "/error"
  end
end

get '/comment/:id' do
  @link_comments = Comment.where(link_id:params[:id].to_i)
end

def refresh_comments(id)
  Comment.where(link_id: id)
end



