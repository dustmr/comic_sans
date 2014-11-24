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

#------------------HOMEPAGE -------------------------------#

get '/' do
  ##Loads homepage right side bar with 3 comics (currently just 1 tile each)
  ##Half - done
  @inprogress = Project.where(completed: false).limit(3).order(created_at: :desc)
  erb :index
end


post '/project' do
  ## creating a new comic through save button below start a story
  ##DONE
  @project = Project.create(title: params[:title], length: params[:length])
  @tile = @project.tiles.build
  @tile.user = current_user


  @tile.image_data = params[:image_data]
  # @project.length = params[:length]
  # @project.tiles << @tile
  @tile.valid?
  @project.valid?
  p @project.errors
  p @tile.errors
  @project.save
  redirect '/'
end


#-----------------LOGIN PAGE --------------------------------#
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

#----------------Continue A Story Page -------------------------------#

get '/projects' do
  @projects = Project.where(completed: false).order(created_at: :desc)
  erb :'projects'
end

#-------------Add to Story X Page ---------------------------------#

get '/projects/:project_id' do
  @tiles = Tile.where(project_id: params[:project_id])
  @project = Project.find(params[:project_id])
  @posted_users = @project.tiles

  erb :'/project'
end

post '/projects/:project_id' do
  @project = Project.find(params[:project_id])
  # binding.pry
  if @project.tiles.count < 9 && @project.tiles.last.user_id != current_user.id
    @tile = Tile.new(project_id: params[:project_id], user_id: session[:user_id])
    @tile.image_data = params[:image_data]
    @project.tiles << @tile
    @project.save          ##still need some kind of error alert to pop-up to let people know they can't add two tiles in a row.
  else
    return "You can't add two tiles in a row, wait your turn. Ya filthy animal."
  end
  redirect '/'
end



#---------------COMPLETED STORIES ---------------------#

get '/projects/completed' do      
##Loads completed stories page with completed comics (currently just 1 tile each)
##Half - done
  @completed = Project.where(completed: true)
  erb :________
end


#---------------USELESS SHIT --------------------#

# get '/inprogress/:id' do
# ## + button template (will need a corresponding field in respective erb files that gives button value = <%= project.id %>)
#   @comic_inprogress = Project.find params[:id]
#   puts @comic_inprogress.tiles.each do |tile|
#     '/tile/'+tile.id
#   end
# end


# get '/tile/:id.png' do
#   header['Content-type'] = 'image/png'
#   Tile.find(params[:id]).image_data
# end

# post '/project/:id/new' do
#   @tile = Tile.new(title: params[:title])
#   @tile.save
# end
# get '/projects/new' do
#   erb :'projects/new'
# end
