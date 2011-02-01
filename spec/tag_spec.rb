require 'tag'


describe Hutamaul::Tag, "#tag" do

	it "creates an appropriate close tag" do
		tag = Hutamaul::Tag.new "<a arf=snarf>"
		tag.close_tag.should == "</a>" 
	end

	it "trims to an appropriate word" do
		tag = Hutamaul::Tag.new "a lovely long tag"
		trimmed = tag.take_chars 10 
		trimmed.text.should == "a lovely"
	end

	it "trims in the middle if there is no word" do
		tag = Hutamaul::Tag.new "hoogabooga"
		trimmed = tag.take_chars 5
		trimmed.text.should == "hooga"
	end
end
