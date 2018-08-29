# coding: utf-8

require_relative "../Sala"
gem "test-unit"
require "test/unit"

class TestSala < Test::Unit::TestCase
  
    def testConstructor()
        sala = Sala.new("Sala de prueba 1")
        if  sala.clientes() != nil &&
            sala.clientes().length == 0 &&
            assert(true, "")
            sala.nombre().equal?("Sala de prueba 1")
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
        if sala.poblacion != 3
           assert(false, "no se unen los usuarios a la sala de forma correcta")
        assert(true, "")  
        end
    end

    def testDejar()
        monigote = "soy un usuario de juguete"
        sala = Sala.new("Sala de prueba 3")
        sala.unirse(monigote)
        sala.dejar(monigote)
        if sala.poblacion == 0
           assert(true, "")
        assert(false, "no dejó la sala")  
        end
    end
end
  
