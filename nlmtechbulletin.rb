#!/usr/bin/env ruby
require 'anemone'

Anemone.crawl('http://www.nlm.nih.gov/pubs/techbull/tb.html') do |anemone|
  anemone.on_every_page { |page| puts page.url }
  anemone.focus_crawl do |page| 
    page.links.find_all { |link| /techbull/ =~ link.to_s } 
  end
end

