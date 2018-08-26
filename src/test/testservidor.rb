# coding: utf-8
require_relative "../servidor"
gem "test-unit"
require "test/unit"

class TestServidor < Test::Unit::TestCase

  @servidor = Servidor.new()
  
   def test_Constructor 
          if  @servidor.getConexiones() != nil &&
              @servidor.getSalas() != nil &&
              @servidor.getClientes() != nil &&
              @servidor.getConectados() == 0 
              @servidor.getContadorSalas() == 0
              assert(true)
          assert(false, "Las variables del constructor no han sido inicializadas")   
          end     
    end

    def test_getConexiones
          if  @servidor.getConexiones() != nil &&
              @servidor.getConexiones().length == 0 &&
              @servidor.getConectados == 0
              assert(true)
          assert(false, "no hay hash de conexiones")  
          end  
     end

     def test_getSalas
         if  @servidor.getSalas() != nil &&
             @servidor.getConexiones().length == 0 &&
             @servidor.getConectados == 0
             assert(true)
         assert(false, "no hay una lista de salas")
         end    
     end

     def test_getClientes
         @servidor.registro("sujeto de prueba 1")
         @servidor.registro("sujeto de prueba 2")
         @servidor.registro("sujeto de prueba 3")
         assert_equal(3 ,servidor.getConectados())
     end

     def test_crearSala
         @servidor = Servidor.new()
         @servidor.crearSala("Sala Lounge VIP")
         assert_equal(1, servidor.getContadorSalas())
         @servidor.creaSala("Sala Lounge VIP")
         if @servidor.getContadorSalas() == 2
         assert(false, "se están agregando salas repetidas")
     end

     def test_Registro
         @servidor.registro("sujeto de prueba 3")
         if  servidor.getConectados == 4
             asser(false, no se permiten usuarios repetidos)
         else if @servidor.getConexiones[:cliente]["sujeto de prueba 3"] == nil
             assert(false, "no está agregando nuevos usuarios")
         end  
     end

     def test_unirseSala
       servidor.unirseSala("sujeto de prueba 3", "Sala Lounge VIP")
       if  servidor.getConexiones()[:salas]["Sala Lounge VIP"] == nil
           assert(false, "No crea las salas")
       else if servidor.getConexiones()[:salas]["Sala Lounge VIP"].length != 1
           assert(false, "Usuario no se unió a la sala solicitada")
       end  
end



