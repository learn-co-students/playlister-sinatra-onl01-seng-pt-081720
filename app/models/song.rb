require_relative './concerns/slugifiable'
class Song < ActiveRecord::Base
    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    # def slug
    #     slug = name.downcase.strip.split(" ")
    #     slug = slug.join("-")
    #     slug
    # end

end