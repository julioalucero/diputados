class Estado < ActiveRecord::Base

  LEGACY_CONSTRAINTS = [:numero, :letra, :pasada, :tipo, :fechaent, :comision]

  belongs_to :expediente
  belongs_to :comision, :class_name => Comision, :foreign_key => :comision

  # dictamenes arme un array con los hashes de los distintos tipo de resultados
  # que tubo como resultado en la comision.
  def dictamenes
    [(
    {:tipo => "Firmantes del Dictamen de mayoria",:fecha => fechamay, :dictamen => dictmay} if dictmay >""
    ), (
    {:tipo => "Firmantes del Dictamen de minoria",:fecha => fechamin1, :dictamen => dictmin1} if dictmin1 >""
    ), (
    {:tipo => "Firmantes del Segundo Dictamen de minoria",:fecha => fechamin2, :dictamen => dictmin2} if dictmin2 >""
    )].delete_if {|x| x == nil}
  end

end
