require 'nokogiri'
require 'open-uri'
require 'byebug'

doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))

webpageCode = File.open 'webpage.html', 'w'
webpageCode.write(doc)
webpageCode.close

nameElements = doc.css('td[width="35%"]>strong')
names = []
nameElements.each do |nm| names << nm.text end

valueElements = doc.css('td[width="14%"]>strong')
values = []
valueElements.each do |nm| values << nm.text end

pairs = names.zip(values).to_h
col_names = ["id", "fulldate", "month", "date", "year", "day", "week", "created_at", "updated_at", "acrodictys", "agrocybe", "algae", "alternaria", "arthimium", "ascomycetes", "asperisporium", "basidiomycetes", "beltrania", "botrytis", "cercospora", "cladosporium", "curvularia", "d_conidia_hyphae", "dendryphiella", "drechslera_helmintho", "dichotomophthora", "diplococcum", "epicoccum", "fusariella", "ganoderma", "helicomina", "microsporum", "misc_fungus_hyaline", "monodictys", "myxomycete_smut", "nigrospora", "penicillium_aspergillus", "periconia", "pithomyces", "powdery_mildew", "puccinia", "rust", "spegazinia", "stemphyllium", "tetrapola", "tilletia", "torula", "pestalotiopsis", "pseudocercospora", "polythrincium", "pleospora", "ash", "walnut", "birch", "cotton_wood", "dogwood", "elm", "glandular_mesquite", "hackberry", "hickory", "mulberry", "maple", "osage_orange", "oak", "sycamore", "pine", "privet", "sweet_gum", "gingko_biloba", "willow", "amaranth", "burweed___marshelder", "cattail", "dog_fennel", "lambs_quarters", "ragweed", "rumex", "sagebrush", "saltbrush", "sedge", "ashe_juniper___bald_cypress", "bushes", "sneezeweed", "black_gum", "other_weed", "other_tree", "plantago", "partridge_pea", "pigweed", "alder", "cedar", "hazelnut", "plum_grannet", "aster", "nettle", "magnolia", "wild_carrot"]
