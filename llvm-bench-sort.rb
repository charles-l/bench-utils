#!/usr/bin/env ruby
require 'csv'

File.open("bench.sorted.csv", "wb") do |f|
    f.puts ["test", "lto", "thin"].to_csv
    f.puts CSV.read("bench.csv")[1..-1]
        .sort {|a, b| a[1].to_f - a[2].to_f <=> b[1].to_f - b[2].to_f}
        .map(&:to_csv)
end
