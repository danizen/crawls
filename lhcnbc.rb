#!/usr/bin/env ruby
require 'anemone'

Anemone.crawl('http://lhncbc.nlm.nih.gov/') do |anemone|
  anemone.on_every_page { |page| puts page.url }
end

