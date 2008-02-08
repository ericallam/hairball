require File.join(File.dirname(__FILE__), "lib", "html3000")
require 'rake'
require 'rake/testtask'

desc "recreate the parser from the treetop grammar file"
task :build do
  puts "calling " + "tt " + File.join(File.dirname(__FILE__), "lib", "html3000", "html3000.treetop")
  exec "tt " + File.join(File.dirname(__FILE__), "lib", "html3000", "html3000.treetop")
end

desc "run all tests"
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end 
end

desc "run benchmarks to compare HTML3000 and HAML"
task :benchmark do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_benchmark.rb']
    t.verbose = true
  end
end

