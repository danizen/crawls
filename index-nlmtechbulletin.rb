#!/usr/bin/env ruby
#
# NOTE: This code is unfisished and probably won't even run
#
require 'anemone'
require 'rsolr'

rsolr = RSolr.connect :url => 'http://localhost:8983/solr/crawl'
ixbuffer = []

Anemone.crawl('http://www.nlm.nih.gov/pubs/techbull/tb.html') do |anemone|
  anemone.focus_crawl do |page| 
    page.links.find_all { |link| /techbull/ =~ link.to_s } 
  end
  anemone.on_every_page do 

    # Not good ruby, but it ain't bad pseudo code
    ixbuffer.push { :id => page.url, :title => page.doc.title ... }

    if (ixbuffer.size > 1000) do
      rsolr.add(ixbuffer)
      ixbuffer.clear()
    end
  end
end

if (ixbuffer.size > 0) do
  rsolr.add(ixbuffer)
  ixbuffer.clear
end

rsolr.commit

