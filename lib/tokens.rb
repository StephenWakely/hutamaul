#
#
#
require 'tag'

module Hutamaul
	
  ##
	# A simple state machine taking in characters and churning
	# out tokens
	#
	class TokenMachine
		attr_accessor :text

	  # Initialize the machine as empty	
	  def initialize 
			@text = nil 
		end

		##
		# Set up with the first character of the next tag
		#
		def reinitialize first_char
			@text = first_char
			@type = first_char == "<" ? :tag : :text
			@state = :running
		end

		##
		# Reset the machine ready for the next tag
		#
		def reset first_char
			reinitialize first_char
		end

		##
		# Accept the next char.
		# Return false if the char belongs in the next token
		#
	  def accept next_char
			if @text.nil?			
				reinitialize(next_char) 
				return true
			else
				if @state == :closed or next_char == "<"
					return false
				end
		 
				if @type == :tag and next_char == ">"
					# This closes the tag
					@state = :closed
				end
		
				add_char next_char
				return true
			end
		end
	
		def add_char next_char
			@text << next_char
		end	
	end

  ##
	#  Breaks down the input text into html tokens 
	#  which are enumerated in the each method.
	#
	#
	class Tokens
	  def initialize input
	    @input = input
	  end
	
	  def each
			token = TokenMachine.new 
	    @input.each_char do |current|
				if !token.accept(current)
	      	# This token has been loaded
					yield Tag.new(token.text)
						
					# On to the next one
					token.reset current
				end
	    end
	
			yield Tag.new(token.text) if !token.nil?
	  end
	
	end
end
