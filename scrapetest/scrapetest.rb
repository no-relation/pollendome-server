require 'nokogiri'
require 'open-uri'
require 'byebug'
require 'mail'
require "rubygems/text"
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

nameElements = doc.css('td[width="35%"]>strong')
page_names = nameElements.map do |nm| nm.text.strip end
names = page_names.map do |name| 
    col_names.each do |oldname| 
        puts "#{name} -> #{oldname}: #{ld.call(name, oldname)}"
    end
end
valueElements = doc.css('td[width="14%"]>strong')
values = valueElements.map do |nm| nm.text.strip end
# byebug

data = names.zip(values).to_h
puts data

