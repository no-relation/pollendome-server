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
            "  Artemeisia (Sage)": 'sagebrush',
            "  Oidium/Erysiphe": 'powdery_mildew',
            "  Ascopores": 'ascomycetes',
            "  Smuts/Myxomycetes": 'myxomycete_smut'
        }

        def todays_params
            col_names = Day.columns.map{|col| col.name}
            ld = Class.new.extend(Gem::Text).method(:levenshtein_distance)

            # current column names of Day table
            doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))

            # find date on page and turn into text
            date = doc.css('font[color="#02789C"]')[0].text

            # nokogiri selects page elements for species names; have to redo if webpage is redesigned
            nameElements = doc.css('td[width="35%"]>strong')
            page_names = nameElements.map do |nm| 
                name = nm.text.strip
                if EXCEPTIONS.keys.include?(name.to_sym)
                    EXCEPTIONS[name.to_sym]
                else    
                    name 
                end
            end
            names = page_names.map do |name| 
                lev_dists = col_names.map do |oldname| 
                    ld.call(name, oldname)
                end
                col_names[lev_dists.index(lev_dists.min)]
            end

            # find today's counts on the page
            values = doc.css('td[width="14%"]>strong').map { |nm| nm.text.strip }

            params = {fulldate: date}.merge(names.zip(values).to_h)
            params.delete("id")
            return params
        end

        day = Day.new(todays_params)
        if Day.where(fulldate: day.fulldate).length != 0 
            puts "Day with that date already exists"
        else 
            day.save
            puts "Created Day #{day.id}: #{day.fulldate}"
        end
    end
end