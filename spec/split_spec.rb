require 'tag'
require 'split'

describe Hutamaul::Split, "#split" do

  it "takes a tag and a line" do
		tag = Hutamaul::Tag.new "<code>"
		line = Hutamaul::Tag.new "arfle"

		split = Hutamaul::Split.new tag, line 
	
		split.tag.should == "code"
		split.line.should == "arfle"
	end

	it "takes a complex tag and gets a decent name" do

		tag = Hutamaul::Tag.new "<a href='yadada' bong=plong ung=pung>"
		line = Hutamaul::Tag.new "arfle"

		split = Hutamaul::Split.new tag, line 
	
		split.tag.should == "a"
	end

	it "splits before the word" do

		tag = Hutamaul::Tag.new "<a>"
		line = Hutamaul::Tag.new "a lovely long tag"
	
		split = Hutamaul::Split.new tag, line	
		
		split.take_chars 10
		split.before_word
		
		split.split_line.text.should == "a lovely"

	end

	it "splits at the character" do

		tag = Hutamaul::Tag.new "<a>"
		line = Hutamaul::Tag.new "a lovely long tag"
	
		split = Hutamaul::Split.new tag, line	
		
		split.take_chars 10
		split.at_character
		
		split.split_line.text.should == "a lovely l"
	end

	it "splits before the line" do

		tag = Hutamaul::Tag.new "<a>"
		line = Hutamaul::Tag.new "some code that we like\nand then some more code that we like"
	
		split = Hutamaul::Split.new tag, line	
		
		split.take_chars 30
		split.before_line
		
		split.split_line.text.should == "some code that we like\n"


	end

end
