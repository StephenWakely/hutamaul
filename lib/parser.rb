#
#
require 'branch'

module Hutamaul
	module Parser

		##
		# Takes in a list of Tokens which it enumerates through
		# and builds up the parse tree
		#	
		def self.parse tokens
			parse_tree = Hutamaul::Branch.new nil
	
			tokens.each { |token|
				parse_tree << token
			}
	
			parse_tree
		end
	end
end
