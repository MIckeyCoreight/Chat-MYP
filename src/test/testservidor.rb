require_relative "../servidor"
gem "test-unit"
require "test/unit"

class TestServidor < Test::Unit::TestCase

        def test_servidor
                assert(true, "Prueba unitaria solo para ver que corra")
        end
end



