require 'socket'

server = TCPServer.new 2000
puts "servidor a la espera de clientes"	
loop do
  Thread.start(server.accept) do |client|
    client.puts "|=PROTOCOLO:"
    #client.puts "Time is #{Time.now}"
    #recibe(client)
    client.puts "salir"
    client.close
  end

  def recibe(client)
    recibido = client.gets
    while recibido.equals?("salir")
      puts recibido
      recibido = client.gets
    end  
  end
end
