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

    

    post "/songs" do
        
        @song = Song.create(params[:song])
        artist = nil
        
        
        if Artist.find_by(name: params[:artist][:name])
            artist = Artist.find_by(name: params[:artist][:name])
            
        else
            artist = Artist.create(name: params[:artist][:name])
           
        end
        
        @song.genre_ids = params[:genres]
        # genres = params[:genres]
        # genres.each do |genre|
        #     @song.genres << genre
        # end
         
        @song.artist = artist
        
        slug = @song.slug
       
          
        #redirect("/songs/#{@song.slug}")
        redirect to :"/songs/#{slug}"


    end

    get "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end
    
    get "/songs/:slug/edit" do
        @genres = Genre.all
        @song = Song.find_by_slug(params[:slug])
        
        erb :"songs/edit"
    end

    patch "/songs/:slug" do
        
        @song = Song.find_by_slug(params[:slug])
        
        song.name = params[:song][:name]
        
        if Artist.find_by(name: params[:artist][:name])
            @artist = Artist.find_by(name: params[:artist][:name]) 
        else
            @artist = Artist.create(name: params[:artist][:name])
        end
        genres = params[:genres]
        
        @song.artist = @artist

        genres.each do |g|
            @song.genre_ids = g
        end
        
        @song.save
        
        erb :"songs/show"
    end

end




#song name params[:song][:name]
#artist name params[:artist][:name]
#"That One with the Guitar"