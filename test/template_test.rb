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
  
  def test_iteration
    users = [
        OpenStruct.new(:name => "Eric"),
        OpenStruct.new(:name => "Larry"),
        OpenStruct.new(:name => "Dray"),
        OpenStruct.new(:name => "Casey"),
        OpenStruct.new(:name => "Ken")
        ]
    puts HTML3000::Template3000.new(:like_rails, :users => users).src
    html = HTML3000::Template3000.new(:like_rails, :users => users).to_html
    assert_equal html, %{<div class="users"><div class="user">hello Eric</div><div class="user">hello Larry</div><div class="user">hello Dray</div><div class="user">hello Casey</div><div class="user">hello Ken</div></div>}
  end
  
end