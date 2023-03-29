require 'sinatra' 
require 'sinatra/activerecord'
require 'rack/method_override'


require File.expand_path(File.join('controllers', 'application_controller'))
require File.expand_path(File.join('models', 'rooms'))
require File.expand_path(File.join('models', 'users'))
require File.expand_path(File.join('models', 'booking'))

Dir[File.join('controllers', '**/*_controller.rb')].each {|file| require File.expand_path(file)}
