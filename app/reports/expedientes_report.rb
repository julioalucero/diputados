require 'prawnbot'
#include MyReport
require 'open-uri'

class ExpedientesReport < Prawnbot::Report

  def initialize
    super
    @header_title = "CAMARA DE DIPUTADOS"
    @header_subtitle = "Provicina de Santa Fe"

    @logo = "#{Rails.root}/app/assets/images/santa_fe_escudo_logo.png"
    @water_print = "#{Rails.root}/app/assets/images/santa_fe_escudo_fondo.png"

  end

  def index(datos, params)
    body

    show_title "Listado de expedientes"

    informacion_de_busqueda(params)

    header_row = [ %w[  ID
                        Numero
                        Tipo
                        Pasada
                        Letra
                        Entrada
                        Autor
                        Firmantes
                        ] ]

    valores_tabla = datos.all.map do |r|
      data_row = %W[  #{r.id}
                      #{r.numero}
                      #{r.tipo_format}
                      #{r.pasada}
                      #{r.letra}
                      #{r.fechaentr}
                      #{r.autor}
                      #{r.firmantes} ]
    end

    rows = header_row + valores_tabla
    widths = { 7 => 160 }

#    move_down 30

    mytable rows, :column_widths => widths

    render
  end

  def show(expediente)
    body

#   Detalles generales
#   TODO: falta agregar prefer.
    show_title "DETALLE DE EXPEDIENTE"

    show_title "#{expediente.clave}"

    myform([
      "<b>Autor</b> #{expediente.autor}",
      "<b>Tema</b> #{expediente.tema.try(:name)}",
      "<b>Estado</b> #{expediente.estado}"])

    myform(["Descripcion"])

    mybox(expediente.descrip)

    myform(["Firmantes",expediente.firmantes])

    mybox("Entrada: #{expediente.fechaentr}, Por: #{expediente.tipoentr} a las #{expediente.hora} en el periodo #{expediente.tipoperiod} N #{expediente.numperiodo}")

    expediente.finals.each do |final|
      mybox(final.descripcion)
    end

#   Asuntos entrados

    expediente.asuntos.each do |asunto|
      myform(["<b>AS.entrado:</b> #{asunto.asuntoentr} <b>Reunion:</b> #{asunto.numreunion} <b>Sesion:</b> #{asunto.numsesion}"])

      myform(["<b>COMISIONES ASIGNADAS</b> (desde As. Entrados)"])

      valores_tabla = asunto.comisiones.map do |comision|
        data_row = %W[#{comision.try(:name)}]
      end
      mytable (valores_tabla) if valores_tabla

    end

    myform(["<b>Pase por comisiones</b>"])

    expediente.estados.each do |estado|

      myform(["<b>#{estado.comision.try(:name)}</b>",
              "<b>Entrada</b> #{estado.fechaent}"])
      estado.dictamenes.map do |dictamen|
        mybox("#{dictamen[:tipo]} #{dictamen[:fecha]} #{dictamen[:dictamen]}]")
      end

      myform(["<b>Salida:</b> #{estado.fechasal}"])
    end

    move_down 10

    myform ["<b>TRATAMIENTO EN SESION</b>"]

#  Sesion.
#  TODO:faltan datos aca. ver en la vista.
    if expediente.sesion
      mybox("Tratamiento #{expediente.sesion.tratamient} Resultado de la votacion: #{expediente.sesion.resuvotac} Fecha de sesion #{expediente.sesion.fechases}")
    else
      mybox "Sin tratamiento en session"
    end

    render
  end
end
