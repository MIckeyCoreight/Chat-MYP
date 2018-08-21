require 'socket'

class Cliente
   def initialize(socket)
      @socket = socket
      while mensaje = socket.gets
	      	puts mensaje	
      end
      socket.close	  
 end
end


socket = TCPSocket.open( "localhost", 2000 )
Cliente.new( socket )
