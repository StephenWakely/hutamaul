require 'parser'
require 'tokens'
tree = Parser.parse Tokens.new('<a>yay</a>')
	puts tree.to_s