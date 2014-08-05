class Square

	attr_accessor :mark

	def ==(other_mark)
		if stringify(other_mark) =~ /[XO]/
			return true if stringify(mark) == stringify(other_mark)
		end
	end

	private

	def stringify(mark)
		mark.to_s.upcase
	end

end