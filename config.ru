#require main application file and define the rack

require File.expand_path(File.join('config', 'application'))

map('/') { run ApplicationController}
run Sinatra::Application