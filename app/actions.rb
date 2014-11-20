# Homepage (Root path)
get '/' do
  erb :index
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
  @tile.image_data = params[:data_image]

  @project.tiles << @tile 
  @project.save
end

post '/project/:id/tile' do
  @tile = Tile.new(title: params[:title])
  @tile.save
end