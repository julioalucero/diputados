# Add the posibility to read the assigned comisions.

module Comisionable

  # @return [Array<Comision>] Comisiones asignadas en el orden correcto.
  def comisiones
    comisiones_ids = [comision1, comision2, comision3, comision4, comision5,
      comision6].delete_if { |i| i == 0 }
    # I make use of an on memory array to avoid multiple queries.
    comisiones_array = Comision.where(:id => comisiones_ids).all
    comisiones_ids.map do |i|
      comisiones_array.detect { |c| c.id == i }
    end
  end

end
