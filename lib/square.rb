class Square

	attr_accessor :mark

	def ==(square_or_mark)
		return true if stringify(mark) == stringify(square_or_mark)[/^[XO]$/] 
	end

	def to_s
		return mark.to_s if mark
		"_"
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end