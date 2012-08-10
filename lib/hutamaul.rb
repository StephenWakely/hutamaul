require 'parser'
require 'tokens'
require 'branch'
require 'options'
require 'split'
require 'tag'

module Hutamaul

	##
	#
	# Splits the html at the given character.
	#
	def self.split html, at_chars, ellipses = '', &options_block
		branch = Parser.parse(Tokens.new(html))
		split = branch.take_chars at_chars, ellipses, &options_block
		split.to_html
	end

	##
	#
	# Extracts the given selectors from the html
	#
	def self.extract html, selectors
		branch = Parser.parse(Tokens.new(html), selectors)
		branch.to_html
	end
end
