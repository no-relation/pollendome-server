require 'nokogiri'
require 'open-uri'
require 'byebug'
require "rubygems/text"

namespace :scrape do

    desc "for the scraping of webpages to create Day objects"
    task houston_pollen: :environment do
        def todays_params
            ld = Class.new.extend(Gem::Text).method(:levenshtein_distance)

            # current column names of Day table
            doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))

            # find date on page and turn into Date object
            date = doc.css('font[color="#02789C"]')[0].text

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
            # nokogiri selects page elements; have to redo if webpage is redesigned
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


            valueElements = doc.css('td[width="14%"]>strong')
            values = valueElements.map do |nm| nm.text.strip end
            fulldate = {fulldate: date}

            puts fulldate.merge(names.zip(values).to_h)
            return {fulldate: date}.merge(names.zip(values).to_h)
        end

        Day.create(todays_params)
    end
end