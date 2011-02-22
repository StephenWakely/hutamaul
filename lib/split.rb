
module Hutamaul

	class Split
		attr_accessor :line
		attr_accessor :split_line
		attr_accessor :tag
					
		def initialize tag, line, ellipses = ""
			@tag = parse_tag(tag.text)
			@line = line.text
			@ellipses = ellipses
		end

		def take_chars chars
			@chars = chars
		end

		# Extracts the tag name.
		#
		# <a> becomes a
		# <a href='yadada'> also becomes a
		# blah becomes '' and is a duff tag name
		#
		def parse_tag tag
			tag_name = /\<(\w+).*>/.match tag
			tag_name.length > 1 ? tag_name[1] : ""
		end

		##
		#
		# Split the given text before the word where the split occurs
		#
		def before_word
			new_text = split_to_word(self.line, @chars - @ellipses.length) + @ellipses
			self.split_line = Tag.new(new_text)
		end

		##
		#
		# Splits at the previous line break
		#
		def before_line
			new_text = split_to_line(self.line, @chars - @ellipses.length) + "\n" + @ellipses
			self.split_line = Tag.new(new_text)
		end

		##
		#
		# Splits the word at that character regardless of word spacing.
		#
		def at_character
		  self.split_line = Tag.new(self.line[0..@chars - @ellipses.length - 1]	+ @ellipses)
		end
	private

		def split_to_line text, chars
			split_to_character text, chars, "\n"
		end

		def split_to_word text, chars
			split_to_character text, chars, ' '
		end
		
		def split_to_character text, chars, character			
			pos = chars
			pos = pos - 1 while text[pos - 1,1] != character and pos > 0
	
			if pos > 1 
				text[0..pos - 2]
			else
				# There is no word break, so we have to just split halfway through
				text[0..chars - 1]
			end
		end
	end

end
