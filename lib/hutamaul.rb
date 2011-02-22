require 'parser'
require 'tokens'
require 'branch'
require 'options'
require 'split'
require 'tag'

module Hutamaul

	def self.split html, at_chars, ellipses = '', &options_block
		branch = Parser.parse(Tokens.new(html))
		split = branch.take_chars at_chars, ellipses, &options_block
		split.to_html
	end

end
