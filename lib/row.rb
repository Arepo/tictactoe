require_relative 'square'

class Array

	def square(num) 
		self[num - 1]
	end

	def to_s
		map {|square| square.to_s }.join
	end

	def marked_by?(source)
		any? {|square| square.source == source if square.mark }
	end

	def get_mode
		#this method (inc ninvert) nabbed from Google
		(inject(Hash.new(0)) { |hash,element| hash[element] += 1; hash }.ninvert.max || [[]]).last
	end

end

class Hash
	def ninvert
		inject({}) { |h,(k,v)| (h[v] ||= []) << k; h }
	end
end
