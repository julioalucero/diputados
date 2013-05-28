class ExpedientesReport
  EXPEDIENTES = [ :clave, :autor, :entrada,  :firmantes, :descripcion, :estado, :tema ]
  DETAILED_EXPEDENTE =  [:clave, :autor, :tema, :estado, :descripcion, :firmantes, :tipoentr, :hora, :tipoperiod, :numperiodo, :tratamiento, :resultado, :fechases, :periodo]
  COMISION = [:nombre, :entrada, :salida]
  DICTAMEN = [:tipo, :fecha, :dictamen]

  attr_accesible :file_path

  def report
    ODFReport::Report.new(Rails.root.join(file_path)) do |r|

      r.add_section "EXPEDIENTES", expedientes do |s|
        EXPEDIENTES.each do |attribute|
          s.add_field(attribute) { |item| item[attribute].to_s }
        end
      end

    end
  end



  def detailed_report
    ODFReport::Report.new(Rails.root.join(file_path)) do |r|

      TO_REPORT_DETAILED.each do |attribute|
        r.add_field(attribute) { |item| item[attribute].to_s }
      end

      r.add_section "COMISION", @expediente.estados do |s|

        COMISION.each do |attribute|
          s.add_field(attribute) { |estado| estado[attribute].to_s }
        end

        s.add_section("DICTAMEN", :dictamenes) do |ss|
          DICTAMEN.each do |attribute|
            ss.add_field(attribute) { |n| n[attribute].to_s }
          end

        end
      end

    end
  end

  def listado proyectos, params
    self.file_path = "app/reports/expedientes.odt"
    report.generate
  end

  def detalle(params)
    @expediente = Expediente.find(params[:id])
    self.file_path = "app/reports/expediente.odt"
    detailed_report.generate
  end

end
