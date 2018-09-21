# Documentation
class CargoWagon < Wagon
  attr_accessor :volume_total
  attr_reader :volume_occupied

  def initialize(volume_total)
    @volume_total = volume_total
    @volume_occupied = 0
    attach_number
    validate!
  end

  def book_volume(volume)
    @volume_occupied += volume
  end

  def occupied_volume
    @volume_occupied
  end

  def free_volume
    @volume_total - @volume_occupied
  end

  protected

  def validate!
    raise 'Введите числовое значение!' unless @volume_total.is_a?(Numeric)
    raise 'Количество объема превышено' if @volume_total == @volume_occupied

    true
  end
end
