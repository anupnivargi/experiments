require 'benchmark'

def factorial_with_range(range)
  (1..range).to_a.each_slice(range/4).to_a.each do |elements|
    elements.each do |element|
      factorial(element)
    end
  end
end

def factorial_with_range_threaded(range)
  threads = []
  (1..range).to_a.each_slice(range/4).to_a.each do |elements|
    threads << Thread.new do
      elements.each do |element|
        factorial(element)
      end
    end
  end
  threads.each(&:join)
end

def factorial(n)
  (1..n).to_a.inject(:*)
end

Benchmark.bm(30) do |bm|
  [4000, 5000].each do |num|
    bm.report("Single Threaded #{num}") do
      factorial_with_range(num)
    end

    bm.report("Multi Threaded #{num}") do
      factorial_with_range_threaded(num)
    end

  end

end
