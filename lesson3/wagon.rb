class Wagon

  include Manufacturer

  attr_reader :number

  def attach_number
    @number = rand(10000)
  end
end
