require 'rack-flash'
class SongsController < ApplicationController
    use Rack::Flash

    
    #Index

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    #New

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    post '/songs' do
     #create a new song
      #create a new artist
     @song = Song.create(params[:song])
     @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
     @song.genre_ids = params[:genres]
     @song.save
     flash[:message] = "Successfully created song."
     redirect to ("/songs/#{@song.slug}")
    end

    #Show

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    #Update

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
     @song = Song.find_by_slug(params[:slug])
     @song.update(params[:song])
     @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
     @song.genre_ids = params[:genres]
     @song.save
     flash[:message] = "Successfully created song."
     redirect to ("/songs/#{@song.slug}")
    end

end