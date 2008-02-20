require 'test_helper'
require 'haml'
require 'benchmark'

class HairballBenchmarksTest < Test::Unit::TestCase
  include ParserTestHelper
  
  def setup
    @parser ||= HairballParser.new
  end
  
  def do_haml(template)
    @text = File.read(File.join(File.dirname(__FILE__), "fixtures", template))
    engine = Haml::Engine.new(@text)
    engine.render
  end
  
  def do_hairball(template)
    eval parse(fixture(template)).source, binding
  end
  
  def test_small_template
    puts "== TEST SMALL TEMPLATE =="
    Benchmark.bmbm do |x|
      x.report("HAML")  { do_haml("show.haml")  }
      x.report("Hairball") { do_hairball("show.habl") }
    end
  end
  
  def test_big_template
    puts "== TEST BIG TEMPLATE =="
    Benchmark.bmbm do |x|
      x.report("HAML")  { do_haml("big_show.haml")  }
      x.report("Hairball") { do_hairball("big_show.habl") }
    end
  end
  
end