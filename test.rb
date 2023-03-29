require 'sinatra'

get '/' do
    'hello eric'
end

get '/say/*/to/*' do
    '<h1>Please wait! We are checking room availibility</h1>'

end

get '/hello/:name' do
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    "Anyyeong #{params['name']}!"
  end