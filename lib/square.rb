class Square

	attr_accessor :mark

	def ==(square_or_mark)
		return true if stringify(mark) == stringify(square_or_mark)[/^[XO]$/] 
	end

	def to_s
		mark.to_s
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end