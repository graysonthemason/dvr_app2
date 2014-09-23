require 'rubygems'
require 'bcrypt'
require 'haml'
require 'sinatra'
 
enable :sessions
 
userTable = {}
 
helpers do
  
  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end
  
  def username
    return session[:username]
  end
  
end
 
get "/" do
  haml :index
end
 
get "/signup" do
  haml :signup
end
 
post "/signup" do
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
  
  #ideally this would be saved into a database, hash used just for sample
  userTable[params[:username]] = {
    :salt => password_salt,
    :passwordhash => password_hash 
  }
  
  session[:username] = params[:username]
  redirect "/"
end
 
post "/login" do
  if userTable.has_key?(params[:username])
    user = userTable[params[:username]]
    if user[:passwordhash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
      session[:username] = params[:username]
      redirect "/"
    end
  end
  haml :error
end
 
get "/logout" do
  session[:username] = nil
  redirect "/"
end