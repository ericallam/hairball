require 'rubygems'
require 'treetop'
files = %w(hairball template)
dir = File.join(File.dirname(__FILE__), 'hairball')
files.each {|f| require(File.join(dir, f))}