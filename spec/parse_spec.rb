require 'parser'

describe Hutamaul::Parser, "#parser" do
  it "parses a single tag" do
  	tree = Hutamaul::Parser.parse Hutamaul::Tokens.new("<div/>")
	  tree.to_s.should ==
"-<div/>
"
	end	

	it "parses a single branch" do
		tree = Hutamaul::Parser.parse Hutamaul::Tokens.new('<a>yay</a>')
		tree.to_s.should ==
"-<a>
--yay
"
	end

	it "parses two branches" do
  	tree = Hutamaul::Parser.parse Hutamaul::Tokens.new("<div>arr</div><div>ooog</div>")
		tree.to_s.should ==
"-<div>
--arr
-<div>
--ooog
"
	end

	it "parses sub branches" do
		tree = Hutamaul::Parser.parse(Hutamaul::Tokens.new("<div>arr<span>oog</span>rah</div>"))

		tree.to_s.should ==
"-<div>
--arr
--<span>
---oog
--rah
"
	end

	it "extracts only spans when asked" do
		tree = Hutamaul::Parser.parse(Hutamaul::Tokens.new("<div>arr<span>oog</span>rah</div>"), ["span"])

		tree[0].to_s.should ==
"<span>
-oog
"
	end

end
