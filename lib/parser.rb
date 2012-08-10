#
#
require 'branch'

module Hutamaul
	module Parser

		##
		# Takes in a list of Tokens which it enumerates through
		# and builds up the parse tree
		#	
		def self.parse tokens, selectors=[]
			parse_tree = Hutamaul::Branch.new nil
	
			tokens.each { |token|
				parse_tree << token
			}
			
			if !selectors.empty?
				parse_tree.extract selectors
			else	
				parse_tree
			end
		end
	end
end
