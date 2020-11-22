module Slugifiable

    module InstanceMethods
        def slug
            self.name.to_s.parameterize
    end
end

    module ClassMethods
        #uses slug method tp to retrieve song/artist/genre from 
        #the database and return that entry
        #this is what will be displayed "hotline-bling" instead of song/1
        def find_by_slug(slug)
            self.all.find{|i| i.slug == slug}
    end
end


end