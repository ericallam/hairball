require 'test_helper'
require 'haml'
require 'benchmark'

class HTML3000BenchmarksTest < Test::Unit::TestCase
  include ParserTestHelper
  
  def setup
    @parser ||= HTML3000Parser.new
  end
  
  def do_haml(template)
    @text = File.read(File.join(File.dirname(__FILE__), "fixtures", template))
    engine = Haml::Engine.new(@text)
    engine.render
  end
  
  def do_html3000(template)
    eval parse(fixture(template)).source, binding
  end
  
  def test_small_template
    puts "== TEST SMALL TEMPLATE =="
    Benchmark.bmbm do |x|
      x.report("HAML")  { do_haml("show.haml")  }
      x.report("HTML3000") { do_html3000("show.3000") }
    end
  end
  
  def test_big_template
    puts "== TEST BIG TEMPLATE =="
    Benchmark.bmbm do |x|
      x.report("HAML")  { do_haml("big_show.haml")  }
      x.report("HTML3000") { do_html3000("big_show.3000") }
    end
  end
  
end