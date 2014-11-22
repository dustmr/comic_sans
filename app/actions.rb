# Homepage (Root path)

enable :sessions

helpers do
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end

# get '/' do                ## Fancy login thinger should likely link here right Dustin? - JI
#   erb :login
# end

# post '/' do
#   username = params[:username]                ##When user inputs "Artist name:" then we create a new user and
#   create_user = User.new(username: username)  ##redirect to Home page with drawing panel on left and comics on right - JI
#   session[:user_id] = existing_user.id
#   redirect '/homepage'
# end

get '/' do
  ##Loads homepage - JI
  @inprogress = Project.where(completed: false).limit(3)
  erb :index
end



get '/inprogress/:id' do
  ## + button template (will need a corresponding field in respective erb files that gives button value = <%= project.id %>)
  @comic_inprogress = Project.find params[:id]
  puts @comic_inprogress.tiles.each do |tile|
    '/tile/'+tile.id
  end
end

get '/tile/:id.png' do
  header['Content-type'] = 'image/png'
  Tile.find(params[:id]).image_data
end

get '/create' do
  erb :'tiles/create'
end

get '/project/:id' do
  @project = Project.find(:id)
  erb :'/projects'
end

post '/project' do
  # creating a new comic through save button below start a story
  @project = Project.new(title: params[:title])
  @tile = Tile.new
  @tile.image_data = params[:image_data]

  @project.tiles << @tile
  @project.save
  redirect '/'
end

post '/project/:id/tile' do
  @tile = Tile.new(title: params[:title])
  @tile.save
end

get '/projects' do
  @projects = Project.order(:created_at)
  erb :'projects'
end

get '/projects/new' do
  erb :'projects/new'
end


get '/login' do
  erb :'login'
end

post '/login' do
  username = params[:username]
  password = params[:password]
  user = User.where(username: username, password: password).first
  if user
    session[:user] = user.username
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/signup' do
  @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/signup'
  end


end
