require "test_helper"
Treetop.load File.join(File.dirname(__FILE__), '../lib/html3000/hairball')

class HairballTest < Test::Unit::TestCase
  include ParserTestHelper
  
  def setup
    @parser = HairballParser.new
  end
  
  def test_element_name
    assert_parses('@content { }')
    assert_parses('@h1 { }')
    assert_parse_failure('@1h {}')
    assert_parse_failure('@h7 {}')
    assert_parse_failure('@h0 { }')
    assert_parse_failure('@h$ { }')
  end
  
  def test_attributes_parsing_on_standard_elements
    assert_parses('@content[key:"value"] { }')
    assert_parses('@content[key:"value"] {}')
    assert_parses('@content[key:"value";another:"value"] {}')
    assert_parses('@content[key:"value"; another:"value"] {}')
    assert_parse_failure('@content[key:"value] {}')
    assert_parse_failure('@content[key:value] {}')
    assert_parse_failure('@content[key] {}')
    assert_parse_failure('@content["value"] {}')
  end
  
  def test_ruby_parsing
    assert_parses("<% Object.class %>")
  end
  
  def test_ruby_with_block_parsing
    assert_parses("<% Object.new do %><% end %>")
    assert_parses("<% Object.new do %><%end%>")
    assert_parses("<% Object.new do %><%     end            %>")
    assert_parses("<%Object.new do%><% end %>")
    assert_parse_failure("<% Object.newdo %><% end %>")
    assert_parse_failure("<% Object.new do %>")
    assert_parse_failure("<% end %>")
  end
  
  def test_ruby_block_argument_parsing
    assert_parses("<% Object.new do |one| %><% end %>")
    assert_parses("<% Object.new do |one,two| %><% end %>")
    assert_parses("<% Object.new do |one,    two   | %><% end %>")
    assert_parses("<% Object.new do |one     ,two   | %><% end %>")
    assert_parses("<% Object.new do |     one    | %><% end %>")
    assert_parse_failure("<% Object.new do || %><% end %>")
    assert_parse_failure("<% Object.new do|one| %><% end %>")
    assert_parse_failure("<% Object.new do |one,| %><% end %>")
    assert_parse_failure("<% Object.new do |,one| %><% end %>")
    assert_parse_failure("<% Object.new do |one,two,three,| %><% end %>")  
  end
  
  def test_ruby_multiline_block_parsing
    assert_parses("
      <% Object.new do %>
        <% @ruby.is.here %>
      <% end %>
    ")
  end
  
  def test_ruby_block_parsing_with_nested_elements
    assert_parses('<% Object.new do %> "This is a string" <% end %>')
    assert_parses('<% Object.new do %> @html {} <% end %>')
    assert_parses('<% Object.new do %> @html { @tag {} } <% end %>')
    assert_parses('<% Object.new do %> <% Object.methods.size %> <% end %>')
  end
  
  def test_parsing_with_newlines
    to_parse = <<-3000.chomp
      @html {
        @body { }
      }
      3000
    assert_parses(to_parse)
    to_parse = <<-3001.chomp
      @html {
        @body {
          #content {
            .login {
              @a[href:"google.com"] { "Login" }
            }
          }
        }
      }
      3001
      assert_parses(to_parse)
  end
  
  def test_parsing_siblings
    to_parse = <<-3001.chomp
      @html {
        @body { }
        @content { }
      }
      3001
    assert_parses(to_parse)
    to_parse = <<-3001.chomp
      @html {
        .body { }
        #content { }
      }
      3001
    assert_parses(to_parse)
    to_parse = <<-3001.chomp
      @html {
        .body { <% Object.class %> }
        #content { "Hello World" }
      }
      3001
    assert_parses(to_parse)
    to_parse = <<-3001.chomp
      @html {
        .body { 
          @world { "Hello" }
        }
        #content { }
      }
      3001
    assert_parses(to_parse)
  end
  
  def test_attributes_parsing_on_div_elements
    assert_parses('.content[key:"value"] {}')
    assert_parses('#content[key:"value"] {}')
    assert_parses('#content[key:"value";another:"value"] {}')
    assert_parses('.content[key:"value"; another:"value"] {}')
    assert_parse_failure('#content[key:"value] {}')
    assert_parse_failure('.content[key:value] {}')
    assert_parse_failure('#content[key] {}')
    assert_parse_failure('.content["value"] {}')
  end
  
  def test_div_with_class
    assert_parses('.content{}')
    assert_parses('.content { }')
    assert_parses('.content {}')
    assert_parse_failure('.content')
    assert_parse_failure('blah.content {}')
    assert_parse_failure('....content {}')
  end
  
  def test_div_with_id
    assert_parses('#content {}')
    assert_parse_failure('#content')
    assert_parse_failure('# content {}')
  end
  
  def test_string
    assert_parses('"hello world"')
  end
  
  def test_any_html_element
    assert_parses("@strong {}")
    assert_parses("@strong { @em {} }")
    assert_parses('@strong { @em { "This be a string" } }')
    assert_parses('@em { @h1 { "This is the Title Text" } }')
    assert_parse_failure("@@strong")
    assert_parse_failure("@ strong")
    assert_parse_failure("@Strong")
    assert_parse_failure("@really_strong")
  end
  
  def test_div_with_nesting
    assert_parses(".content { }")
    assert_parses('.content { "some tex" }')
    assert_parses(".content { .anothercontent { } }")
    assert_parses(".content { .anothercontent { .contentagain { } } }")
    assert_parses("#content { #anothercontent { #contentagain { } } }")
    assert_parses("#content { .anothercontent { #contentagain {} } }")
    assert_parse_failure("#content { blah blah }")
    assert_parse_failure("#content {")
    assert_parse_failure("#content {}}")
    assert_parse_failure("#content {{{}}")
  end
  
  # ==================
  # = Source Testing =
  # ==================
  
  def test_parsing_siblings_source_and_result
    to_parse = %q{@html {@body { }@content { }}}.chomp
    assert_source to_parse, %q{_src='';_src.concat('<html>');_src.concat('<body>');_src.concat('</body>');_src.concat('<content>');_src.concat('</content>');_src.concat('</html>');_src;}.chomp
    assert_result to_parse, "<html><body></body><content></content></html>"
  end
  
  def test_ruby_source_and_result
    assert_source "<% Object.class %>", "_src='';_src.concat(( Object.class ).to_s);_src;"
    assert_result "<% Object.class %>", "Class"
  end
  
  def test_ruby_block_source_and_result
    to_parse = %q{<%[1,2,3].collect do |i|%><% i %><% end %>}
    assert_parses(to_parse)
    assert_source to_parse, %q{_src='';[1,2,3].collect do |i|;_src.concat(( i ).to_s);end;_src;}
    assert_result to_parse, "123"
  end
    
  def test_attributes_source_on_standard_elements
    to_parse = '@em[key:"value"] {}'
    assert_source to_parse, %{_src='';_src.concat('<em key="value">');_src.concat('</em>');_src;}
    assert_result to_parse, %{<em key="value"></em>}
  end
    
  def test_any_html_element_source
    assert_source "@strong {}", %{_src='';_src.concat('<strong>');_src.concat('</strong>');_src;}
    assert_source '@em { @h1 { "This is the Title Text" } }', %{_src='';_src.concat('<em>');_src.concat('<h1>');_src.concat('This is the Title Text');_src.concat('</h1>');_src.concat('</em>');_src;}
    assert_result '@em { @h1 { "This is the Title Text" } }', "<em><h1>This is the Title Text</h1></em>"
  end
  
  def test_div_class_source
    assert_source ".content {}", %{_src='';_src.concat('<div class="content">');_src.concat('</div>');_src;}
    assert_source '.content { "hello world" }', %{_src='';_src.concat('<div class="content">');_src.concat('hello world');_src.concat('</div>');_src;}
    assert_result '.content { "hello world" }', %{<div class="content">hello world</div>}
  end
    
  def test_div_id_source
    assert_result "#content {}", %{<div id="content"></div>}
  end
      
  def assert_result(to_parse, expect)
    assert_equal eval(parse(to_parse).source), expect
  end
  
  def assert_source(to_parse, src)
    assert_equal parse(to_parse).source, src
  end
  
  def assert_parses(input)
    assert !parse(input).nil?
  end
  
  def assert_parse_failure(input)
    assert parse(input).nil?
  end
  
end