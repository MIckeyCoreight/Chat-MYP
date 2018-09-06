# coding: utf-8

require_relative "../Sala"
gem "test-unit"
require "test/unit"

class TestSala < Test::Unit::TestCase

    def testConstructor()
        sala = Sala.new("Sala de prueba 1")
        if  sala.clientes() != nil &&
            sala.poblacion() == 0 &&
            sala.nombre().include?("Sala de prueba 1")
        assert(true, "")
        else
	    assert(false, "el constructor no funciona")
        end
    end

    def testUnirse()
        monigoteUno = "soy un usuario de juguete"
        monigoteDos = "soy un usuario de juguete"
        monigoteTres = "soy un usuario de juguete"
        sala = Sala.new("Sala de prueba 2")
        sala.unirse(monigoteUno)
        sala.unirse(monigoteDos)
        sala.unirse(monigoteTres)
        if sala.clientes()[monigoteUno] != nil &&
           sala.clientes()[monigoteDos] != nil &&
           sala.clientes()[monigoteTres] != nil &&
           sala.poblacion() == 3
            assert(true, "prueba pasada unirse()")
        else
             assert(false, "no se están uniendo los usuarios/ el contador no funciona")
        end
    end

    def testDejar()
        monigote = "soy un usuario de juguete"
        sala = Sala.new("Sala de prueba 3")
        sala.unirse(monigote)
        if sala.poblacion() != 1
          assert(false, "el contador no funciona")
        end
            sala.dejar(monigote)
        if  sala.poblacion == 0
            assert(true, "")
        else
            assert(false, "no dejó la sala")
        end
    end
end
