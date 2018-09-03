# coding: utf-8

require_relative "../Cliente"
gem "test-unit"
require "test/unit"

class TestCliente < Test::Unit::TestCase
	
	def intialize()	
		@puerto = 1024 + Random.rand(64000)
		@client = Cliente.new()
		servidor()
	end
	
	def servidor()
		servidor = TCPServer.open(@puerto, direccion)
		loop{
			cliente = servidor.accept
			cliente.puts("|=PROTOCOLO:")
			cliente.close
		}	
	end

	def test_Cliente
		if  @cliente != nil
			assert(true, "el cliente no es válido")			
		assert(false ,"el cliente es válido ")
	        end	
        end        
                
	def test_conecta
		assert_not_equal("|=PROTOCOLO:", cliente.conecta())		
	end

	def test_envia()
		cliente.envia("Midoriya Izuku")
		assert_not_equal("Midoriya Izuku", cliente.envia())
	end

        def test_recibe()
            assert(false, "placeholder")
        end  

  end

