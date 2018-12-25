require 'csv'

# Summary:
#   Generate undirected edges to load data into Cytoscape
#
# Usage:
#   ruby split.rb 0000.tags.csv >0000.graph.csv

graph = []

CSV.foreach(ARGV[0]) do |line|
  tags = line[0].split('-').map{|t| t.gsub('#', '') }.combination(2).to_a
  graph.push(*tags.map(&:sort))
end

graph.sort_by!(&:to_s).uniq!(&:to_s)
tags_count = graph.flatten.each_with_object(Hash.new(0)) { |n, h| h[n] += 1 }.sort_by{|k, v| -v }.to_h

too_many = tags_count.take(10).to_h
warn 'too many: ' + too_many.inspect

not_enough = tags_count.select{|_, v| v == 1 }
warn 'not enough: ' + not_enough.inspect

ignore = (too_many.keys + not_enough.keys).sort.uniq
# ignore = []

graph.select!{|t1, t2| !ignore.include?(t1) && !ignore.include?(t2) }
graph.each do |t1, t2|
  puts t1 + ',' + t2
end

