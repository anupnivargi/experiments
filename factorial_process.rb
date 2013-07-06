require 'benchmark'

THREADS = 4

def factorial_with_range(range)
  pids = []
  (1..range).to_a.each_slice(range/4).to_a.each do |elements|
    pids << fork do
      elements.each do |element|
        factorial(element)
      end
    end
  end
  Process.waitall
end

def factorial(n)
  (1..n).to_a.inject(:*)
end

Benchmark.bm(30) do |bm|
  [4000, 5000].each do |num|
    bm.report("Multi Process #{num}") do
      factorial_with_range(num)
    end
  end
end
