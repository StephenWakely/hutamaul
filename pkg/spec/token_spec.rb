require 'tokens'

describe Tokens, "#tokens" do
  def count_tokens tokens
    count = 0;
    tokens.each { |token|
      count = count + 1;
    }
    count
	end

  it "creates an open tag as a token" do
    count_tokens(Tokens.new("<a>")).should == 1
  end

  it "creates an open and close tag as two tokens" do
    count_tokens(Tokens.new "<a></a>").should == 2
  end

  it "creates an open and close tag with text as three tokens" do
    count_tokens(Tokens.new "<a>argle</a>").should == 3
  end

  it "creates tags with text and subtags as six tokens" do
    count_tokens(Tokens.new "<a>argle<b>floog</b></a>").should == 6
  end

	it "creates an appropriate close tag" do
		token = Token.new.create_with_text "<a arf=snarf>"
		token.close_tag.should == "</a>" 
	end
end  