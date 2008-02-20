require 'rubygems'
require 'treetop'
files = %w(hairball template)
dir = File.join(File.dirname(__FILE__), 'html3000')
files.each {|f| require(File.join(dir, f))}