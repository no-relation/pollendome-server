require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.houstontx.gov/health/Pollen-Mold/'))

webpageCode = File.open 'webpage.html', 'w'
webpageCode.write(doc)
webpageCode.close