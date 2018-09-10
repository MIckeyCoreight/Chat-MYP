# coding: utf-8

require_relative "../Cliente"
gem "test-unit"
require "test/unit"
require "socket"

class TestCliente < Test::Unit::TestCase

	  def testMain()
			 servidorAuxiliar()
			 socket = TCPSocket.open("localhost", 8080)
			 cliente = Cliente(socket)
			 assert(true, "hola")
		end


		def servidorAuxiliar()
			socketServidor = TCPSocket.open( 8008, "localhost")
			 Thread.start(socketServidor)  do |conexion|
			 conectados = Hash.new()
					loop do
					    cliente = socketServer.accept()
							Thread.start(cliente) do |conexion|
							 			mensaje = cliente.gets.chomp
										conectados[cliente] = cliente
										conectados.keys.each do |otro|
												conectados[otro].puts mensaje
										end
							 end
					end
			end
		end

		def testEnvia()
		end

		def testRecibe()
		end

end
