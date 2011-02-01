#
#
require 'branch'

module Parser

	def self.parse tokens
		parse_tree = Branch.new nil

		tokens.each { |token|
			parse_tree << token
		}

		parse_tree
	end
end
