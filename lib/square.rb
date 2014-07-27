class Square

	attr_accessor :mark

	def ===(other_mark)
		if other_mark == "X" || other_mark == "O"
			true if mark == other_mark
		end
	end

end