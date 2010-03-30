require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'pp'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.sqlite3")

class Ping
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String
  property :contents, Text, :lazy => false
end
DataMapper.auto_upgrade!

post '/:url' do
  Ping.create(:url => params[:url], :contents => "testing")
end

get '/:url' do
  Ping.all(:url => params[:url]).collect{|ping| "<div>#{ping.contents}</div>"}.join("")
end