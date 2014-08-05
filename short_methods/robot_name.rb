class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
  end

  def generate_name

    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_random_name
    end
    add_to_registry_if_valid(@name)
  end

  private

  def generate_random_name
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }
      "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def add_to_registry_if_valid(name)
    if !(name =~ /^[[:alpha:]]{2}[[:digit:]]{3}$/) || @@registry.include?(name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
    @@registry << @name
  end

end


# Errors!
generator = -> { 'AA111' }
# robot1 = Robot.new(name_generator: generator)
robot = Robot.new(name_generator: generator)
# robot1.generate_name
robot.generate_name
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

