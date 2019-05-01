require 'nokogiri'
require 'open-uri'
require 'byebug'
require "rubygems/text"

namespace :scrape do

    desc "for the scraping of webpages to create Day objects"
    task houston_pollen: :environment do

        # names where calculating Levenshtein distance doesn't give best answer; might need additions, haven't seen all the names they use for the daily page yet
        EXCEPTIONS = {
            "  Acer (Maple)": 'maple',
        "  Pinaceae (Pine)": 'pine',
        "  Betula (Birch)": 'birch',
        "  Quercus (Oak)": 'oak',
        "  Cupressaceae (Cedar)": 'cedar',
        "  Tilia (Linden)": '???',
        "  Fraxinus (Ash)": 'ash',
        "  Ulmus (Elm)": 'elm',
        "": '???',
        "  Artemeisia (Sage)": 'sagebrush',
        "  Rumex (Sheep Sorel)": 'rumex',
        "  Asteraceae (Aster)": 'aster',
        "  Cyperaceae(Sedge)": 'sedge',
        "  Oidium/Erysiphe": 'powdery_mildew',
        "  Ascopores": 'ascomycetes',
        "  Smuts/Myxomycetes": 'myxomycete_smut'
        }

        def todays_params
            # current column names of Day table
            col_names = Day.columns.map{|col| col.name}
            ld = Class.new.extend(Gem::Text).method(:levenshtein_distance)

            doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))

            # nokogiri selects page elements for species names; have to redo if webpage is redesigned
            nameElements = doc.css('td[width="35%"]>strong')
            page_names = nameElements.map do |nm| 
                name = nm.text.strip
                # replace known LevDist exceptions
                if EXCEPTIONS.keys.include?(name.to_sym)
                    EXCEPTIONS[name.to_sym]
                elsif name.blank?
                    "???"
                else    
                    name 
                end
            end
            # compare name in database to name on webpage and find the Levenshtein distances, select the one with the smallest distance
            names = page_names.map do |name| 
                lev_dists = col_names.map do |oldname| 
                    ld.call(name, oldname)
                end
                col_names[lev_dists.index(lev_dists.min)]
            end

            # find today's counts on the page
            values = doc.css('td[width="14%"]>strong').map { |val| val.text.strip }

            # find date on page and turn into text
            fulldate = {fulldate: doc.css('font[color="#02789C"]')[0].text}

            params = {fulldate: date}.merge(names.zip(values).to_h)
            byebug
            params.delete("id")
            return params
        end

        day = Day.new(todays_params)
        if day.valid?
            puts "Created Day: #{day.fulldate}"
            puts "Emailing home"
            AppMailer.new_day_log(day).deliver
            day.save
        else
            puts day.errors.messages
        end
    end
end