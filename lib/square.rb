class Square

	attr_accessor :mark

	def ===(other_mark)
		if other_mark =~ /[XO]/
			true if mark.to_s == other_mark.to_s
		end
	end

end