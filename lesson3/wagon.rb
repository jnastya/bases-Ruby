# Documentation
class Wagon
  include Manufacturer

  attr_reader :number

  def attach_number
    @number = rand(10_000)
  end
end
