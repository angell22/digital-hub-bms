class ApplicationController < Sinatra::Base 
    enable:sessions
    # Set folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../views', '_FILE_')

    ## index page
    get '/' do 
        erb :index
    end 

    # login page
    get '/login' do
        erb :login
    end

    # login route
    post '/login/verify' do
        if session[:booking?] == true
            @user = User.find_by(email: params[:email])
            session[:user_id] = @user.id
            redirect "/booking/#{session[:room_id]}/create"
            
        else
            @user = User.find_by(email: params[:email])
            session[:user_id] = @user.id
            redirect "/profile"

        end
        # "im here"
    end

    # retrieve user's information from database
    get 'users/:id' do
        @user = User.find(params[:id])
        erb :user
    end
end
