require 'pry'

helpers do
  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def get_error
    if session[:error]
      @error = session[:error]
      session[:error] = nil
    end
  end
end

before do
  current_user
  get_error
end


configure do
  enable :sessions
end



get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @songs = Song.all
  erb :'songs/songs'
end

get '/songs' do
  # "Add a song!"
  @songs = Song.all
  erb :'songs/songs'
end

get '/songs/new' do
  user = session[:user_id]
  if user
    @song = Song.new
    erb :'songs/new'
  else
    session[:error] = "Must be logged in to post a song"
  end
end

post '/songs' do
  #order songs here (i.e., somewhere under post '/songs' do)
  @song = Song.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url],
    user_id: session[:user_id]
    )
  if @song.save
    redirect'/songs'
  else
    erb :'/songs/new'
  end
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/users/register' do
  @user = User.new
  erb :'users/register'
end

post '/users/register' do
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password]
  )
  # erb :'users/register'
  if @user.save
    redirect '/songs'
  else
    erb :'/users/register'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  name = params[:name]
  password = params[:password]

  user = User.find_by(name: name, password: password)

  if user
    session[:user_id] = user.id
    redirect '/songs'
  else
    session[:error] = "Invalid user name or password"
    erb :'/users/login'
  end
end

get '/users/logout' do
  session.clear
  redirect '/songs'
end

post '/songs/votes/:id' do
  @song = Song.find params[:id]
  vote = @song.votes.create(song_id: @song.id, user_id: current_user.id)
  vote = Vote.find_by(song_id: @song.id)
  vote.total += 1
  vote.user_id = current_user.id
  redirect '/songs'
end

