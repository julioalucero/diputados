# Encoding: UTF-8
require 'test_helper'
require 'legacy/status_migration'

class LegacyStatusMigrationTest < ActiveSupport::TestCase

  def test_migration_con_excluidos
    Status.delete_all
    migration = Legacy::StatusMigration.new :legacy => "status.dbf", :model => Status
    migration.run
    assert Status.where(:nombre => "").count.zero?, "hay migraciones vacías"
    assert Status.where(:nombre => "En Carátula").count.nonzero?, "hay migraciones omitidas de más"
  end

end

