module ApplicationHelper

    #Onglet Title
    def title
        base_title = "Lnclass Education"
        if @title.nil?
        base_title
        else
        "#{@title} • #{base_title}"
        end
    end
    def app_name
        "Lnclass Education"
    end

    def language
        "fr"
    end
    #site description
    def description
        "Prepa Bac, Comprendre Philosophie."
    end
        
    #Site Keys worlds
    def keywords
        "Tle, Bac, Terminale A1 Terminale A2,2nd C ..."
    end
    
    #Theme color
    def theme_color
        "#020408"      
    end
        
    def tileColor
        "#020408"
    end
end
