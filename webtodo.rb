require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'

class Webtodo < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, '3000'

  #class Webtodo
    # get '/lists' do
    #   "Hello World"
    # end


  #end

# AUTHORIZATION STUFF
  # def current_user
  #   username = request.env["HTTP_AUTHORIZATION"]
  #   User.find_by_name username
  # end

# PRINT ALL THE (UNDONE?) ITEMS ON A LIST => WORKS, BUT SHOWS DONE AS WELL AS UNDONE
  get '/lists/:name' do
    l = List.find_by_name(params[:name])
    l.to_json
    list_id = l.id
    i = Item.where list_id: list_id
    i.to_json
  end

# PRINT ALL ITEMS (UNDONE ONLY?) ON ALL LISTS => KIND OF WORKS
  get '/lists' do
    items = []
    l = List.order(id: :asc)#.to_json => can't each over json.
    l.each do |list|
      list_id = list.id
      i = Item.where list_id: list_id
      i.each do |item|
        #puts "#{list.name}: #{item.name}, Due: #{item.due}, Done? #{item.completed}" # #{item.list_id}"
        items << "#{list.name}: #{item.name}, Due: #{item.due}, Done? #{item.completed}\n\n" # #{item.list_id}"
      end
    end
    items # need to return a string
  end

# CREATE NEW LIST => WORKS
  post '/lists' do
    #List.current_user.lists.find_or_create! name: params["name"]
    l = List.create! name: params["name"]
    l.to_json
  end

# LOOK AT ALL ITEMS => WORKS
  get '/items' do
    Item.order(id: :asc).to_json
  end

# CREATE A NEW ITEM ON A LIST => WORKS
  post '/items' do
    #i = Item.find_or_create! name: params["name"], list_id: params["list_id"]#, due: params["due"], list_id: params["list_id"]
    i = Item.create! name: params["name"], list_id: params["list_id"], due: params["due"]
    i.to_json
  end

  
# ADD A DUE DATE TO AN ITEM
  post '/items/:name' do
    i = Item.find_by_name(params[:name])
    if params["due"]
      i.add_duedate params["due"]
    end
    if params["completed"] != nil
      i.done!
    end
    i.to_json
  end


# NEXT ITEM
# SEARCH ITEMS

end

Webtodo.run!