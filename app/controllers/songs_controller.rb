class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    post '/songs' do
        if !params[:song].empty?
            song = Song.create(name: params[:song])
            if !params[:artist].empty?
                existing_artist = Artist.find_by(name: params[:artist])
                if !!existing_artist
                    song.artist = existing_artist
                    song.save
                else
                    song.artist = Artist.new(name: params[:artist])
                    song.save
                end
            end
            if !params[:genres].empty?
                params[:genres].each do |genre_name|
                    existing_genre = Genre.find_by(name: genre_name)
                    if !!existing_genre
                        song.genres << existing_genre
                    else
                        song.genres << Genre.create(name: genre_name)
                    end
                end
            end
            session[:new_song] = "Yes"
            redirect "/songs/#{song.slug}"
        else
            redirect '/songs/new'
        end
    end

    get '/songs/:slug' do
        @message = nil
        if !!session[:new_song]
            @message = "Successfully created song."
            session.delete(:new_song)
        elsif !!session[:edited_song]
            @message = "Successfully updated song."
            session.delete(:edited_song)
        end
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @genres = Genre.all
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        if !params[:song].empty?
            song = Song.find_by_slug(params[:slug])
            song.name = params[:song]

            if !params[:artist].empty?
                artist = Artist.find_by(name: params[:artist])
                if !!artist
                    song.artist = artist
                else
                    song.artist = Artist.new(name: params[:artist])
                end
            end

            song.genres.clear
            if !params[:genres].empty?
                params[:genres].each do |genre_name|
                    song.genres << Genre.find_by(name: genre_name)
                end
            end
            song.save
            session[:edited_song] = "Yes"
            redirect "/songs/#{song.slug}"
        else
            redirect "/songs/#{params[:slug]}/edit"
        end
    end
end