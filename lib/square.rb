class Square

	attr_accessor :mark

	# def initialize
	# 	@mark = Mark.new
	# end

	def ==(other_square)
		return false unless mark && other_square.mark
		return true if (other_square.source == mark.source) 
	end

	def to_s
		return "_" unless mark
		
	end

	def source
		mark.source
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end