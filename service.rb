require "benchmark"
require "net/http"


def fetch(count)
  uri = URI.parse("http://localhost:8000/")
  threads = []
  count.times do 
    threads << Thread.new do
      Net::HTTP.get_response(uri)
    end
  end
  threads.each(&:join)
end

Benchmark.bm(30) do |bm|
  bm.report("IO Service") do
    fetch(20)
  end
end
