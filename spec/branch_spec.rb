

require 'parser'
require 'branch'

describe Hutamaul::Branch, "#branch" do
	it "counts words from a simple tag" do
		branch = Hutamaul::Parser.parse Hutamaul::Tokens.new('<a>yay</a>')
		branch.char_count.should == 3
	end

	it "counts words from a nested tag" do
		branch = Hutamaul::Parser.parse(Hutamaul::Tokens.new("<div>arr<span>oog</span>rah</div>"))
		branch.char_count.should == 9
	end

	it "splits words in a simple tag" do
		branch = Hutamaul::Parser.parse Hutamaul::Tokens.new('<a>hooray</a>')

		split = branch.take_chars 3
		split.to_s.should ==
"-<a>
--hoo
"
	end

	it "splits words in a nested tag" do
		branch = Hutamaul::Parser.parse(Hutamaul::Tokens.new("<div>arr<span>oo ga hoo</span>rah</div>"))

		split = branch.take_chars 7 
		split.to_s.should ==
"-<div>
--arr
--<span>
---oo
"

	end

	it "reconstructs the html from a simple split tag" do
		branch = Hutamaul::Parser.parse Hutamaul::Tokens.new('<a>hooray</a>')
		split = branch.take_chars 3

		split.to_html.should == "<a>hoo</a>"
	end

	it "puts in an ellipses at the appropriate place" do

		branch = Hutamaul::Parser.parse Hutamaul::Tokens.new('<a>hooray yay woohoo</a>')
		split = branch.take_chars 10, '...' 

		split.to_html.should == "<a>hooray...</a>"
	end

end
