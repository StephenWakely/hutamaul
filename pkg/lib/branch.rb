
#
class Branch

  def initialize token
		@this_token = token
		@current_branch = nil
		@branches = []

		@closed = false
	end

	#
	# Pushes new tokens into the branch.
	# Will push the token up any child branches if they havent been closed off.
	def << token
		if current_branch_takes_more
			@current_branch << token
		elsif token.type == :end_tag
			@closed = true
		elsif token.type == :begin_tag 
			@current_branch = Branch.new token 
			@branches << @current_branch
		else
			@branches << token
 		end
	end

  def current_branch_takes_more
		!@current_branch.nil? && !@current_branch.closed?
	end

  def closed?
		return @closed
	end

	def [] index
		@branches[index]
	end

	
	def length
		@branches.length
	end

	def char_count
		@branches.inject(0) { |count, branch|
			count + branch.char_count
		}
	end

	def take_chars chars
		new_branch = Branch.new @this_token
		@branches.each { |branch|
			taken = branch.take_chars chars
    	new_branch.add_branch taken

			chars -= taken.char_count
			break if chars == 0
		}

		new_branch
	end

	def to_html
		if @this_token.nil?
				inner_html
		else
				@this_token.to_html + inner_html + @this_token.close_tag
		end
	end

	def inner_html
		@branches.inject("") { |total, branch|
				total + branch.to_html
		}
	end

	def to_s
		self.to_indented_s(0)
	end

	def to_indented_s level
		this_token = @this_token.nil? ? "" : @this_token.to_indented_s(level) 
		
		@branches.inject(this_token) { |total, branch|
				total + branch.to_indented_s(level + 1) 
		}
	end


	def add_branch branch
		@branches << branch
	end
end

