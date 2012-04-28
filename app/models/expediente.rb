# encoding: utf-8

class Expediente < ActiveRecord::Base

  LEGACY_CONSTRAINTS = [:numero, :letra, :pasada, :tipo]

  Tipos = { 1 => "Ley", 2 => "Comunicación", 3 => "Declaración",
    4 => "Resolución", 5 => "Decreto", 6 => "Mensaje" }
  TiposColection = Tipos.invert

  def tipo
    Tipos[read_attribute(:tipo)] || "No indicado"
  end

  belongs_to :estado, :class_name => Status

  has_many :estados

  # puede ser un has_one, pero no estoy seguro.
  has_many  :asuntos
  has_many  :finals
  has_one   :sesion

  # Al migrar asigno directamente el numero que deberia ser guardado como
  # estado_id y que de otra forma se confunde. Asi hago que funcionen los dos en
  # simultaneo.

  def estado=(estado)
    if estado.is_a? Fixnum
      write_attribute(:estado, estado)
    else
      super
    end
  end

  def entrada
    "#{fechaentr} #{hora} por: #{tipoentr}"
  end

  def periodo
    "#{tipoperiod} Numero: #{numperiodo}"
  end

  def clave
    "#{numero} #{letra} #{tipo_format} (#{pasada})"
  end

  def tipo_format
    "#{tipo} #{ley if tipo == "Ley"}"
  end
end
