def call1
	call2
end

def call2
	call3
end

def call3
	caller
end

p call1