def time(repetitions = 100, &block)
  require 'benchmark'
  Benchmark.bm { |b| b.report { repetitions.times(&block) } }
end

#require ‘benchmark’
#
#include Benchmark
#
#def first
#  bmbm do |x|
#    x.report(‘regex’) do
#      yield
#    end
#  end
#end
#
#def second
#  bmbm do |x|
#    x.report(‘other way’) do
#      yield
#    end
#  end
#end
