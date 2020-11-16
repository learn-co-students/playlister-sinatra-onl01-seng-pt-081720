module Slugifiable
    
    module ClassMethods

        def find_by_slug(name)
            res2 = []
            res = name.split("-")
            res.each do |r|
                if r == "with" || r == "the" || r == "a"
                    res2 << r
                else
                    a = r.capitalize
                    res2 << a
                end
                
            end
            res3 = res2.join(" ")
            
            res4 = self.find_by(name: res3)
            res4
            
        end

    end
    
    module InstanceMethods

        def slug
            slug = (self.name).downcase.strip.split(" ")
            slug = slug.join("-")
            slug
        end

    end
    
end