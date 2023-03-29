class ApplicationController < Sinatra::Base 
    enable:sessions
    # Set folder for templates to ../views, but make the path absolute
    set :views, File.expand_path('../views', '_FILE_')

    ## index page
    get '/' do 
        erb :index
    end 

    # login page
    post '/login' do
        if session[logged_in] == true
            @user = User.find_by(email: params[:email])
            session[:user_id] = @user.id
            
        
        else
            @user = User.find_by(email: params[:email])
            session[:user_id] = @user.id
            redirect "/profile"

        end
    end

    # registration page
    post '/register' do
        username = params[:username]
        password = params[:password]
    end



    # retrieve user's information from database
    get 'users/:id' do
        @user = User.find(params[:id])
        erb :user
    end
end
