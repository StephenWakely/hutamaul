
module Hutamaul

	class Options
		attr_accessor :yielded
					
		def initialize split
			@split = split
			@yielded = false
		end

		##
		#
		# Defines which tags we are going to keeps
		#
		def keep tagselector

		end

    def respond_to?(sym)
	  	# We respond to everything!
		  true
    end

		##
		#
		# Checks if the method called is the tag name of our given split.
		# If it is, we yield the split to it so the client can define how
		# they want to split. 
		#
		def method_missing(sym, *args, &block)
			if !@yielded and ( sym.to_s == @split.tag or sym.to_s == "else" )
	   		block.call(@split) 
				@yielded = true
			end
	  end
  end	
end
