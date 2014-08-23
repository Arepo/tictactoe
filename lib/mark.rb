class Mark

	@mark_number = 1

	def self.mark_number
		@mark_number
	end

	def self.mark_number=(new_number)
		@mark_number = new_number
	end

	def self.new(source = nil)
		super
		# self.mark_number = self.mark_number + 1
	end

	attr_reader :source, :string

	def initialize(source = nil)
		@source = source
		@string = player_mark
	end

	def to_s
		string
	end

	def player_mark
		return "X" if Mark.mark_number == 1
		return "O" if Mark.mark_number == 2
	end

end