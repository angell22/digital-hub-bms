class ApplicationController < Sinatra::Base 

    enable:sessions

    # Set folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../views', '_FILE_')

    ## index page ##
    get '/' do 
        erb :index
    end 

    ## USER ACTION ##
    # login page
    post '/login' do
        username = params[:username]
        password = params[:password]
        
        user = User.find_by(username: username, password_digest: password)

        if user
            session[:user_id] = user.id
            session[:logged_in] = true

            if user.role==false
                redirect '/admin'
            else
                redirect '/home'
            end

        else
            erb :index, locals:{error: 'Invalid!'}
        end

    end

    #user page
    get '/home' do
        if session[:logged_in]
            #find logged in user data
            @users = User.where(id: session[:user_id])
            @rooms = Room.all
            erb :home
        else
            redirect '/'
        end
    end

    #logout page
    get '/logout' do
        session.clear
        redirect '/'
    end

  # Direct to edit user account
    get '/edit/user/:id' do
        @user = User.find(params[:id])
        erb :edit   
    end
  
  

    #update account
    post '/update/user/:id' do
        username = params[:username]
        password_digest = params[:password]
        user_id = params[:id]
        
        user = User.find_by(id: user_id)

        if user.update(username: username, password_digest: password_digest)
            if user.role
                redirect '/admin'
            else
                redirect '/home'
            end
        else
            erb :error, locals:{message: 'Failed to update profile. Try again.'}
        end
    end

    #delete user account 
    get '/delete/user/:id' do
        @user = User.find(params[:id])
        @user.destroy

        redirect '/'
    end

    # registration page
    get '/register' do
        erb :register
    end

    #registration form
    post '/register' do
        username = params[:username]
        password_digest = params[:password]

        user = User.new(username: username, password_digest:password_digest)

        user.save
        redirect '/'
    end 

    # retrieve user's information from database
    get 'users/:id' do
        @users = User.find(params[:id])
        erb :user
    end

    ## ROOM ACTION ##
    #add room
    get '/add_room' do
        erb :add_room
    end

    #create room
    post '/add' do
        room_name= params[:room_name]
        rate= params[:rate]
        capacity= params[:capacity]

        room= Room.new(room_name: room_name, rate: rate, capacity: capacity)

        room.save
        redirect '/admin'
    end

    #view room
    get '/room_list' do
        @rooms = Room.all
        erb :room_list
    end

     # Direct to edit room
     get '/edit/room/:id' do
        @room = Room.find(params[:id])
        erb :edit_room 
    end

    #update room
    post '/update/room/:id' do
        room_name = params[:room_name]
        rate = params[:rate]
        capacity = params[:capacity]
      
        room = Room.find_by(id: params[:id])
      
        if room.update(room_name: room_name, rate: rate, capacity: capacity)
          redirect '/room_list'
        else
          erb :error, locals:{message: 'Failed to update room details. Please try again.'}
        end
    end
    
    #delete room 
    get '/delete/room/:id' do
        @room = Room.find(params[:id])
        @room.destroy

        redirect '/admin'
    end


    ## ADMIN ACTION ##
    #admin page
    get '/admin' do
        if session[:logged_in]
            @users = User.where(id: session[:user_id])

            erb :admin
        else
            redirect '/'
        end
    end

    ## BOOKING ACTION ##

end
