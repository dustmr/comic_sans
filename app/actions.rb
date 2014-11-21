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
  @inprogress = Project.where(completed: false).limit(3)
  erb :index
end

get '/inprogress' do
  
  # <% @inprogress.each do |comic| %>       ##should go in Views area
  #  <% comic.tiles.each do |image| %>
  #  <img src="/tile/<%= puts image.id %>.png />
  #  <% end %>
  # <% end %>
end

get '/inprogress/:id' do              ## + button template (will need a corresponding field in respective erb files that gives button value = <%= project.id %>)
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

post '/project' do     ## creating a new comic through save button below start a story
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
