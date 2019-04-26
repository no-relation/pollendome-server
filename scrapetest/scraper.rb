# WHEN WE LEFT OUR HERO, he was figuring out a better way to scrape, specifically one value at a time rather than zipping the names and the values. Need to find a CSS selector that gets the name, then corrects it to the actual database column name, then finds the cousin (not sibling) element with the associated value
require 'nokogiri'
require 'open-uri'
require 'byebug'
require "rubygems/text"

# def todays_params
    ld = Class.new.extend(Gem::Text).method(:levenshtein_distance)

    # current column names of Day table
    col_names = ["id", "fulldate", "month", "date", "year", "day", "week", "created_at", "updated_at", 
    "acrodictys",
    "agrocybe",
    "algae",
    "alternaria",
        "arthimium",
        "ascomycetes",
        "asperisporium",
        "basidiomycetes",
            "beltrania",
            "botrytis",
            "cercospora",
            "cladosporium",
                "curvularia",
                "d_conidia_hyphae",
                "dendryphiella",
                "drechslera_helmintho",
                    "dichotomophthora",
                    "diplococcum",
                    "epicoccum",
                    "fusariella",
                        "ganoderma",
                        "helicomina",
                        "microsporum",
                        "misc_fungus_hyaline",
                            "monodictys",
                            "myxomycete_smut",
                            "nigrospora",
                            "penicillium_aspergillus",
                                "periconia",
                                "pithomyces",
                                "powdery_mildew",
                                "puccinia",
                                    "rust",
                                    "spegazinia",
                                    "stemphyllium",
                                    "tetrapola",
                                        "tilletia",
                                        "torula",
                                        "pestalotiopsis",
                                        "pseudocercospora",
                                            "polythrincium",
                                            "pleospora",
                                            "ash",
                                            "walnut",
                                                "birch",
                                                "cotton_wood",
                                                "dogwood",
                                                "elm",
                                                    "glandular_mesquite",
                                                    "hackberry",
                                                    "hickory",
                                                    "mulberry",
                                                        "maple",
                                                        "osage_orange",
                                                        "oak",
                                                        "sycamore",
                                                            "pine",
                                                            "privet",
                                                            "sweet_gum",
                                                            "gingko_biloba",
                                                                "willow",
                                                                "amaranth",
                                                                "burweed___marshelder",
                                                                "cattail",
                                                                    "dog_fennel",
                                                                    "lambs_quarters",
                                                                    "ragweed",
                                                                    "rumex",
                                                                        "sagebrush",
                                                                        "saltbrush",
                                                                        "sedge",
                                                                        "ashe_juniper___bald_cypress",
                                                                            "bushes",
                                                                            "sneezeweed",
                                                                            "black_gum",
                                                                            "other_weed",
                                                                                "other_tree",
                                                                                "plantago",
                                                                                "partridge_pea",
                                                                                "pigweed",
                                                                                    "alder",
                                                                                    "cedar",
                                                                                    "hazelnut",
                                                                                    "plum_grannet",
                                                                                        "aster",
                                                                                        "nettle",
                                                                                        "magnolia",
                                                                                        "wild_carrot"]
    
    

    doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))  
    # put Nokogiri output in easily parseable html code
    # webpageCode = File.open 'webpage.html', 'w'
    # webpageCode.write(doc)
    # webpageCode.close

    # find date on page and turn into Date object
    date = doc.css('font[color="#02789C"]')[0].text

    # names where calculating Levenshtein distance doesn't give best answer
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
    # exceptions:
        # ["cercospora", "  Acer (Maple)"], 10; actual: maple, 10
        # ["helicomina", "  Pinaceae (Pine)"], 13 actual: pine, 14
        # ["curvularia", "  Betula (Birch)"], 12; actual: birch, 12
        # ["cercospora", "  Quercus (Oak)"], 10; actual: oak, 13
        # ["created_at", "  Cupressaceae (Cedar)"], 17; actual: cedar, 17
        # ["helicomina", "  Tilia (Linden)"], 12; actual: tilletia(?), 13
        # ["amaranth", "  Fraxinus (Ash)"], 12; actual: ash, 13
        # ["diplococcum", "  Ulmus (Elm)"], 11; actual: elm, 11
        # ["alternaria", "  Artemeisia (Sage)"], 15; actual: sagebrush, 17
        # ["asperisporium", "  Rumex (Sheep Sorel)"], 17; actual: rumex, 17
        # ["ascomycetes", "  Asteraceae (Aster)"], 15; actual: aster, 15
        # ["created_at", "  Cyperaceae(Sedge)"], 14; actual: sedge, 15
        # ["basidiomycetes", "  Oidium/Erysiphe"], 12; actual: powdery_mildew, 14
        # ["cercospora", "  Ascopores"], 7; actual: ascomycetes, 8
        # ["ascomycetes", "  Smuts/Myxomycetes"] 10; actual: myxomycete_smut, 12

    nameElements = doc.css('td[width="35%"]>strong')
    page_names = nameElements.map do |nm| 
        name = nm.text.strip
        if EXCEPTIONS.keys.include?(name.to_sym)
            EXCEPTIONS[name.to_sym]
        # only inside Rails
        # elsif name.blank?
        #     "???"
        else    
            name 
        end
    end
    page_names.each {|name| puts name}
    byebug
    names = page_names.map do |name| 
        lev_dists = col_names.map do |oldname| 
            ld.call(name, oldname)
        end
        col_names[lev_dists.index(lev_dists.min)]
    end
    puts "#{names.size} names"

    valueElements = doc.css('td[width="14%"]>strong')
    values = valueElements.map do |val| val.text.strip end
    puts "#{values.size} values"
    fulldate = {fulldate: date}
    
    params = fulldate.merge(names.zip(values).to_h)
    params.each { |k,v| puts "#{k}: #{v}"}
    puts "size: #{params.size}"

    return params
# end