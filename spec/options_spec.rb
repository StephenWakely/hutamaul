
require 'options'

describe Hutamaul::Options, "#options" do
	# It takes the tag and parameters to decide what to do with that tag

  it "yields given split for its tag" do
		
		split = Hutamaul::Split.new(Hutamaul::Tag.new('<code>'), 
																Hutamaul::Tag.new('oooh')) 

		option = Hutamaul::Options.new split

		run = false
		option.code do |split|
			split.should == split 
			run = true
		end

		run.should == true 
	end

	it "does not yield given split for another tag" do

		split = Hutamaul::Split.new(Hutamaul::Tag.new('<code>'), 
																Hutamaul::Tag.new('oooh')) 

		option = Hutamaul::Options.new split

		run = false
		option.another do |split|
			run = true
		end

		run.should == false 
	end

	it "yields all tags to the else block" do

		split = Hutamaul::Split.new(Hutamaul::Tag.new('<code>'), 
																Hutamaul::Tag.new('oooh')) 

		option = Hutamaul::Options.new split

		run = false
		option.else do |split|
			split.should == split 
			run = true
		end

		run.should == true 
	end

	it "only yields to one block" do

		split = Hutamaul::Split.new(Hutamaul::Tag.new('<code>'), 
																Hutamaul::Tag.new('oooh')) 

		option = Hutamaul::Options.new split

		run = 0 
		option.code { |split| run += 1 }
		option.else { |split| run += 1 }

		run.should == 1 

	end

	it "keeps the tags you want" do


	end
end
