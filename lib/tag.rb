#
#
module Hutamaul
	
	class Tag
	
		attr_accessor :text
    attr_accessor :parent

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

		##
		#
		# Take the chars from the current tag
		#
		# We pass the options to the given block which the caller can
		# use to specify specific options for the split.
		#
		# If no action is taken we default to a simple split at word.
		#
		def take_chars chars, ellipses = '', &options_block

			if split_needed(chars)
				split = Split.new(self.main_tag, self, ellipses)
			  split.take_chars(chars)

				options = Options.new split
				if !options_block.nil?
					options_block.call(options)
				end

				if !options.yielded
					# Default is split to previous word
					split.before_word
				end

				return split.split_line 
			else
				return Tag.new @text
			end
		end

		##
		#
		# Returns the closing tag for this tag.
		#
		def close_tag
			tag_name = /\<(\w+).*>/.match @text
		
			tag_name.length > 1 ? "</" + tag_name[1] + ">" : ""
		end

		##
		#
		# Searches up our parents for the main tag that contains this tag.
		#
		def main_tag
			if self.parent.nil?
				# If we have no parent, we are probably just unit testing...
				Tag.new("<html>")
			else
				self.parent.main_tag
			end
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

	private
		def split_needed chars
			type == :text and @text.length > chars
		end
	end
end
