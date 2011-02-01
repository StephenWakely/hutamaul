#
#
module Hutamaul
	
	class Tag
	
		attr_accessor :text
	
	  def initialize text
			@text = text
		end
		
		def type
	    if @text =~ /^\<\//
				return :end_tag
			elsif @text =~ /\/\>$/
				return :lone_tag
			elsif @text =~ /^\</
				return :begin_tag
			else
				return :text
			end
		end
	
		def char_count
			type == :text ? @text.length : 0
		end
	
		def take_chars chars, ellipses = ''

			if type == :text and @text.length > chars
				return Tag.new self.split_to_word(@text, chars - ellipses.length) + ellipses
			else
				return Tag.new @text
			end
		end
	
		def split_to_word text, chars
			pos = chars
			pos = pos - 1 while text[pos - 1,1] != ' ' and pos > 0
	
			if pos > 1 
				text[0..pos - 2]
			else
				# There is no word break, so we have to just split halfway through
				text[0..chars - 1]
			end
		end
	
		def close_tag
			tag_name = /\<(\w+).*>/.match @text
		
			tag_name.length > 1 ? "</" + tag_name[1] + ">" : ""
		end
	
		def to_html
			@text
		end
	
	  def to_s
			@text
		end
	
		def to_indented_s level
	    ('-' * level) + @text + "\n"
		end
	end
end
