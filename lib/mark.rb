class Mark

	@mark_number = 0

	def self.mark_number
		@mark_number
	end

	def self.mark_number=(new_number)
		@mark_number = new_number
	end

	def self.new(source = nil)
		self.mark_number = self.mark_number + 1
		super
	end

	attr_reader :source, :player_mark

	def initialize(source = nil)
		@source = source
		@player_mark = gauge_mark
	end

	def to_s
		player_mark
	end

	def gauge_mark
		return "X" if Mark.mark_number == 1
		return "O" if Mark.mark_number == 2
	end

end