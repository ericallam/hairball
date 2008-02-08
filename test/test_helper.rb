require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/html3000')

TEMPLATE_ROOT = File.join(File.dirname(__FILE__), "fixtures")

module ParserTestHelper
  def assert_evals_to_self(input)
    assert_evals_to(input, input)
  end
  
  def fixture(file_name)
    File.read(File.join("fixtures", file_name))
  end
  
  def parse(input)
    result = @parser.parse(input)
    unless result
      puts @parser.terminal_failures.join("\n")
    end
    result
  end
end