class KvoTest 
  include BubbleWrap::KVO
	attr_accessor :theArray
	def initialize
		puts "initializing"
		@theArray = []
		observe (self, :theArray) do |old, new|
			puts "observe called with #{old} and #{new}"
		end
		theArray << "a"
		observedArray << "b"
		theArray << "c"
		observedArray << "d"
		puts "resulting theArray: #{theArray}"
		puts "resulting observerArray: #{observedArray}"
	end

	def observedArray
	    puts "observedArray called, returning: #{self.mutableArrayValueForKey :theArray}"
		self.mutableArrayValueForKey :theArray
	end
end