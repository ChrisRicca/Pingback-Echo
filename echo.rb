require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.sqlite3")

class Ping
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String
  property :contents, Text, :lazy => false
  property :created_at, DateTime
end
DataMapper.auto_upgrade!

post '/:url_h3879h23' do
  Ping.create :url => params[:url_h3879h23], :contents => (params).delete_if{|k,v| k == "url_h3879h23"}.inspect
end

get '/:url' do
  Ping.all(:url => params[:url]).collect{|ping| "<div>#{ping.created_at}: #{ping.contents}</div>"}.join("<br/><br/>")
end