require 'socket'
require_relative './Servidor'
require_relative './Cliente'

class Chat

   def initialize()
       queHacer()
   end

   def queHacer()
       puts "Escribe \"servidor\" si quieres iniciar un servidor \n"
       puts "Escribe \"cliente\" si quieres instanciar un cliente \n"
       cadena = $stdin.gets.chomp
       if cadena.eql? "servidor"
          construyeServidor()
       else if cadena.eql? "cliente"
          construyeCliente()
       else
           puts "te pedí que la entrada fuera el \"servidor\" o \"cliente\", necio \n"
           puts "vuelve a intentarlo hasta que hagas lo que te pido UnU. \n \n"
           queHacer()
       end
   end

   def construyeCliente()
    #   begin
       puts "indica el puerto del servidor:"
       puerto = $stdin.gets.chomp
       direccion = $stdin.gets.chomp
       Servidor.new(puerto, direccion)
       rescue SocketError => e
           puts e.message
           puts "el servidor no existe"
       end
  end

   def construyeServidor()
    #   begin
       puts "indica el puerto para iniciar el servidor:"
       direccion = $stdin.gets.chomp
       puts "indica la direccion para iniciar el servidor:"
       puerto = $stdin.gets.chomp
       Servidor.new(puerto, direccion)
       rescue SocketError => e
           puts e.message
           puts "el servidor ya existe"
   end

end

#end

chat = Chat.new()
