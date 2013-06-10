class ExpedientesReport
  EXPEDIENTE_ATTRIBUTES = [ :clave, :autor, :entrada,  :firmantes, :descripcion, :estado, :tema ]
  EXPEDIENTE_DETAILED_ATTRIBUTES =  [:clave, :autor, :entrada, :tema, :estado, :descripcion, :firmantes, :tipoentr, :hora, :tipoperiod, :numperiodo, :tratamiento, :resultado, :fechases, :periodo]
  COMISION = [:nombre, :entrada, :salida]
  DICTAMEN = [:tipo, :fecha, :dictamen]

  #attr_accessible :file_template_path

  def report(expedientes)

    ODFReport::Report.new(Rails.root.join("app/reports/expedientes.odt")) do |r|
    #ODFReport::Report.new(Rails.root.join(self.file_template_path)) do |r|
      r.add_section "EXPEDIENTES", expedientes do |s|
        EXPEDIENTE_ATTRIBUTES.each do |attribute|
          binding.pry
          s.add_field(attribute) { |item| item[attribute].to_s }
        end
      end
    end

  end

  def detailed_report params
    @expediente = Expediente.find(params[:id])
    #ODFReport::Report.new(Rails.root.join(self.file_template_path)) do |r|
    ODFReport::Report.new(Rails.root.join("app/reports/expediente.odt")) do |r|
      EXPEDIENTE_DETAILED_ATTRIBUTES.each do |attribute|
        r.add_field(attribute, @expediente[attribute].to_s)
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

  def listado expedientes
    #self.file_template_path = "app/reports/expedientes.odt"
    report(expedientes).generate
  end

  def detalle params
    #self.file_template_path = "app/reports/expediente.odt"
    detailed_report(params).generate
  end

end
