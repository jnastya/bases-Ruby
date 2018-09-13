class PassWagon < Wagon

  attr_accessor :seats_total
  attr_reader :place, :number

  def initialize(seats_total)
    @seats_total = seats_total
    @seats_occupied = 0
    attach_number
    validate!
  end

  def book_seat
    validate!
    @seats_occupied += 1
  end

  def occupied_places
    @seats_occupied
  end

  def free_places
    @seats_total - @seats_occupied
  end

  protected

  def validate!
    raise "Количество мест должно быть целым числом!" unless @seats_total.is_a?(Integer)
    raise "Количество занятых мест не должно превышать количества мест в вагоне" if @seats_total == @seats_occupied
    true
  end
end
