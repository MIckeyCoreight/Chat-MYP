require 'socket'

class Cliente
  def initialize(socket)
    @socket = socket
    @protocolo = conecta()
    puts @protocolo
    recibe()
    socket.close
  end

  def conecta
    return @socket.gets
  end

  def recibe
    while mensaje = @socket.gets
      puts mensaje
     #@socket.puts envia()
    end
  end

  def envia
    mensaje = "salir"
    return envia
  end  
end


socket = TCPSocket.open( "localhost", 2000 )
Cliente.new(socket)
