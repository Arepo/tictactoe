class Square

	attr_accessor :mark

	def ==(square_or_mark)
		return false if mark == nil
		return true if stringify(mark) == stringify(square_or_mark)[/^[XO]$/] 
		return true if stringify(mark) == stringify(square_or_mark)
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end