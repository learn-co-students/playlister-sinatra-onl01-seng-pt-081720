class SongsController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/")}

    get "/songs" do
        @songs = Song.all
        erb :"songs/index"
    end
    
    get "/songs/new" do
        @genres = Genre.all
        erb :"songs/new"
    end

    get "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end

    post "/songs" do
        @song = Song.create(name: params[:Name])
        artist = nil

        if Artist.find_by(name: params["Artist Name"])
            artist = Artist.find_by(name: params["Artist Name"])
        else
            artist = Artist.create(name: params["Artist Name"])
            
        end
        
        genres = params[:genres]
        genres.each do |genre|
            @song.genre_ids << genre
        end
        
        @song.artist = artist
        
        redirect to :"/songs/#{@song.slug}"

    end

    

end

#song name params[:song][:name]
#artist name params[:artist][:name]
#"That One with the Guitar"