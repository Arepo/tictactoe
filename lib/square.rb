require 'byebug'

class Square

	attr_reader :mark

	def mark=(new_mark)
		@mark = new_mark unless mark
	end

	def ==(other_square)
		return false unless mark && other_square.mark
		return true if (other_square.source == mark.source) 
	end

	def to_s
		return "_" unless mark
		mark.to_s
	end

	def source
		mark.source
	end

	private

	def stringify(square_or_mark)
		square_or_mark.to_s.upcase
	end

end