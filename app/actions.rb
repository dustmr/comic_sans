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

get '/' do      ##Loads homepage - JI
  erb :index
end

post '/inprogress' do
  # @inprogress = Project.find_by_sql "SELECT projects.title, projects.completed, tiles.project_id, tiles.image_data, tiles.created_at FROM tiles WHERE projects.completed = false ON projects.id = tiles.project_id"             ##So now should have a 

  ######
  @inprogress = Project.where(:completed => false)


end


get '/create' do
  erb :'tiles/create'
end

get '/project/:id' do
  @project = Project.find(:id)
  erb :'/projects'
end

post '/project' do
  @project = Project.new(title: params[:title])
  @tile = Tile.new
  @tile.image_data = params[:image_data]

  @project.tiles << @tile 
  @project.save
end

post '/project/:id/tile' do
  @tile = Tile.new(title: params[:title])
  @tile.save
end
