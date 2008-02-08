require "test_helper"
require 'ostruct'
Treetop.load File.join(File.dirname(__FILE__), '../lib/html3000/html3000')

class TemplateTest < Test::Unit::TestCase
  
  def setup
    @html = HTML3000::Template3000.new(:ruby_no_block, :user => OpenStruct.new(:name => "Eric Allam")).to_html
  end
  
  def test_instance_variables_in_ruby_code
    assert_equal @html, "<html><body>Eric Allam</body></html>"
  end
  
end