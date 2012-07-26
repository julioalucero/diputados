# Encoding: utf-8
require 'legacy/migration'

module Legacy
  class StatusMigration < Migration
    def override_attributes(attributes)
      attributes = nil if attributes[:nombre].strip.empty?
      attributes
    end
  end
end

