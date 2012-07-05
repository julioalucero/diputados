# Encoding: UTF-8
require 'test_helper'
require 'legacy/final_migration'

class LegacyFinalMigrationTest < ActiveSupport::TestCase

  def test_migracion_de_registro_vacios
    Final.delete_all
    migration = Legacy::FinalMigration.new :legacy => "final.dbf",
                                             :model => Final

    record = { "NUMERO"=>727,
               "LETRA"=>"DB",
               "TIPO"=>2,
               "PASADA"=>1,
               "NOTA"=>0,
               "NRONOTA"=>0,
               "FECHANOTA"=>nil,
               "NROEXPTE"=>0,
               "RESPU"=>nil,
               "ARCHI"=>nil,
               "TOMO"=>0,
               "LEY"=>0,
               "DECRETO"=>0,
               "PROMU"=>nil,
               "VETO"=>0,
               "TIPOVETO"=>0,
               "EXPVETO"=>0,
               "CADUCADO"=>nil }

    migration.prepare_record  record

    record = { "NUMERO"=>727,
               "LETRA"=>"DB",
               "TIPO"=>2,
               "PASADA"=>1,
               "NOTA"=>0,
               "NRONOTA"=>0,
               "FECHANOTA"=>nil,
               "NROEXPTE"=>0,
               "RESPU"=>nil,
               "ARCHI"=>nil,
               "TOMO"=>0,
               "LEY"=>0,
               "DECRETO"=>0,
               "PROMU"=>nil,
               "VETO"=>0,
               "TIPOVETO"=>0,
               "EXPVETO"=>0,
               "CADUCADO"=>nil }

    migration.migrate_records record

  end

end

