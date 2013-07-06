
def thread1
  100.times do |i|
    puts "In Thread 1 #{Thread.current.hash}"
  end
end

def thread2
  100.times do
    puts "In Thread 2 #{Thread.current.hash}"
  end
end

t1 = Thread.new { thread1 }
t2 = Thread.new { thread2 }

# Join the threads to the main thread
# This prevents the program from exiting
t1.join
t2.join
