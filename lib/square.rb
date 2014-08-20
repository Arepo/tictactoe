class Square

	attr_accessor :mark

	def initialize
		@mark = Mark.new
	end

	def ==(square_or_mark)
		return true if (square_or_mark.source == mark.source) && mark.source
	end

	def to_s
		return "_" unless mark.source
		
	end

	def source
		mark.source
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end