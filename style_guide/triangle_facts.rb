# Killer facts about triangles AWW YEAH
class Triangle
	attr_accessor :side1, :side2, :side3

	def initialize(side1,side2,side3)
		@side1 = side1
		@side2 = side2
		@side3 = side3
	end

	def equilateral?
		 side1 == side2 && side2 == side3
	end

	def isosceles?
		 [side1, side2, side3].uniq.length == 2
	end

	def scalene?
		!(equilateral || isosceles)
	end

	def recite_facts
		if equalateral?
			puts 'This triangle is equilateral!'  
		elsif isosceles?
			puts 'This triangle is isosceles! Also, that word is hard to type.'
		elsif scalene?
			puts 'This triangle is scalene and mathematically boring.'
		end

		angles = self.calculate_angles(side1, side2, side3)
		puts 'The angles of this triangle are ' + angles.join(',')

		if angles.include? 90
			puts 'This triangle is also a right triangle!' 
		end
	end

	def calculate_angles(a, b, c)

		side_a = a**2
		side_b = b**2
		side_c = c**2

		angle_a = radians_to_degrees(Math.acos((side_b + side_c - side_a) / (2.0 * b * c)))
		angle_b = radians_to_degrees(Math.acos((side_a + side_c - side_b) / (2.0 * a * c)))
		angle_c = radians_to_degrees(Math.acos((side_a + side_b - side_c) / (2.0 * a * b)))

		return [angle_a, angle_b, angle_c]
	end

	def radians_to_degrees(rads)
		return (rads * 180 / Math::PI).round
	end
end


triangles = [
	[5, 5, 5],
	[5, 12, 13],
]
triangles.each { |sides|
	tri = Triangle.new(*sides)
	tri.recite_facts
}
