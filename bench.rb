#!/usr/bin/env ruby
require 'csv'

def in_path?(c)
    system("which #{c} > /dev/null 2>&1")
end

abort "ensure cset is in $PATH" unless in_path? "cset"
abort "ensure llvm-lit is in $PATH" unless in_path? "cset"

CSET="sudo #{`which cset`}"

$lto_benchmarks     = 'build-lto/MultiSource/Benchmarks'
$thinlto_benchmarks = 'build-thinlto/MultiSource/Benchmarks'

def all_benchmarks
    `cd #{$lto_benchmarks} && find . -name '*.test'`
end

def compare(test)
    def bench(t, build_dir, runs = 5)
        a = []
        runs.times do
            k = `cd #{build_dir}/ && #{CSET} shield --exec llvm-lit #{t} | grep exec_time`&.split(':')[1]&.strip.to_f
            a << k if k
        end
        a.reduce(:+).to_f / a.size
    end

    puts "benchmark for #{test}"
    puts "lto"
    lto_avg = bench(test, $lto_benchmarks)
    puts "  average time " + lto_avg.to_s

    puts "thinlto"
    thinlto_avg = bench(test, $thinlto_benchmarks)
    puts "  average time " + thinlto_avg.to_s
    {test: test, lto: lto_avg, thin: thinlto_avg}
end

def bench_to_csv(benchmarks)
    CSV.open("bench.csv", "wb") do |csv|
        csv << ["test", "lto", "thin"]
        benchmarks.each do |b|
            csv << (compare b).to_a.map{|e| e[1]}
        end
    end
end

puts all_benchmarks

puts "Run benchmark (all):"
i = gets.chomp

if(i.empty? || i == "all")
    bench_to_csv(all_benchmarks.split("\n"))
elsif i =~ /file (\w+)/
    bench_to_csv(File.read($1).split("\n"))
else
    compare(i)
end

