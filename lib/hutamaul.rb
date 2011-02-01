require 'parser'
require 'tokens'

module Hutamaul

	def self.split html, at_chars, ellipses = ''
		branch = Parser.parse(Tokens.new(html))
		split = branch.take_chars at_chars, ellipses
		split.to_html
	end

end
