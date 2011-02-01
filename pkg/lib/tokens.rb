#
#
#

class Token
  def first_char first_char
		@text = first_char
		@type = first_char == "<" ? :tag : :text
		@closed = false

		self
	end

	def create_with_text text
		@text = text
		@type = text[0] == "<" ? :tag : :text

		self
	end

  def accept next_char
		if @closed
			return false
		end
					
   	if next_char == "<"
			# This belongs in a new token
			return false
		end
 
		if @type == :tag and next_char == ">"
			# This closes the tag
			@closed = true
		end

		add_char next_char
		return true
	end

	def add_char next_char
		@text << next_char
	end	

	def type
	  return @type == :text ? :text : tag_type
	end

	def tag_type
    if @text =~ /^\<\//
			return :end_tag

		elsif @text =~ /\/\>$/
			return :lone_tag

		elsif @text =~ /^\</
			return :begin_tag

		end
	end

	def char_count
		type == :text ? @text.length : 0
	end

	def take_chars chars
		if type == :text and @text.length > chars
			return Token.new.create_with_text @text[0..chars - 1]
		else
			return Token.new.create_with_text @text
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

class Tokens
  def initialize input
    @input = input
  end

  def each
		token = nil
    @input.each_char { |current|
      if token.nil?
			  token = Token.new.first_char current  
			else
				if !token.accept(current)
      		# This token has been loaded
					yield token
					
					# On to the next one
					token = Token.new.first_char current
				end
			end
    }

		yield token if !token.nil?
  end

end
