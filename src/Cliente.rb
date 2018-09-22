require 'socket'
require_relative './Status'
require_relative './Protocolo'

class Cliente

    #Parámetro puerto: el puerto en el que se comunica el Cliente
    #Parámetro dirección la dirección para conectar al cliente
    #Constructor único de la clase Cliente
    def initialize(puerto, direccion)
        @socket = TCPSocket.open(direccion, puerto)
        @envia = envia
        @respuesta = recibe
        @status = Status::ACTIVE
        @envia.join
        @respuesta.join
    end

    #Insatacia un hilo el cual siempre estará leyendo la entrada y envíandola
    #por el socket que creamos con la dirección y el puerto
    def envia
        puts "Por favor registrate con \"IDENTIFY\" "
        begin
           Thread.new do
           loop do
               message = $stdin.gets.chomp
               @socket.puts message
            end
        end
        rescue IOError => e
            #puts e.message
            puts "el servidor está apagado o solicitaste una desconexión"
            @socket.close
        end
    end

    #Instancia un hilo que se dedica a leer los bytes recibidos por el socket y
    #a mostrarlos en pantalla
    def recibe
      begin
        Thread.new do
          loop do
            response = @socket.gets.chomp
            puts "#{response}"
            if response.eql? '|=QUIT:'
              @socket.close
            end
          end
        end
    rescue IOError => e
      puts "Estas desconectado"
      @socket.close
      end
    end

end
