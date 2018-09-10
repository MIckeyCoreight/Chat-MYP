# coding: utf-8

require_relative "../Sala"
gem "test-unit"
require "test/unit"

class TestSala < Test::Unit::TestCase

    def testClientes()
        monigoteUno = "Soy un usuario de prueba uno"
        sala = Sala.new("Sala de prueba para el método clientes()")
        monigoteDos = "soy un usuario de prueba dos"
        monigoteTres = "soy un usuario de prueba tres"
        sala.unirse(monigoteUno)
        sala.unirse(monigoteDos)
        sala.unirse(monigoteTres)
        client = Hash.new()
        client[monigoteUno] = monigoteUno
        client[monigoteDos] = monigoteDos
        client[monigoteTres] = monigoteTres
        client = sala.clientes()
        assert_equal(sala.clientes(), client, "failure")
    end

    def testPoablacion()
        sala = Sala.new("Sala de prueba para el método clientes()")
        monigoteUno = "Soy un usuario de prueba uno"
        monigoteDos = "soy un usuario de prueba dos"
        monigoteTres = "soy un usuario de prueba tres"
        sala.unirse(monigoteUno)
        sala.unirse(monigoteTres)
        sala.unirse(monigoteDos)
        assert_equal(sala.poblacion(), 3, "el contador no funciona")
    end

    def testNombre()
        sala = Sala.new("Sala de pruebas para el método clientes")
        assert_equal(sala.nombre(), "Sala de pruebas para el método clientes", "failure")
    end

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
        monigoteUno = "soy un usuario de juguete 1"
        monigoteDos = "soy un usuario de juguete 2"
        monigoteTres = "soy un usuario de juguete 3"
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
