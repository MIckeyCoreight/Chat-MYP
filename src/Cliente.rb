require 'socket'

class Cliente

    def initialize(puerto, direccion)
        @socket = TCPSocket.open(direccion, puerto)
        @envia = envia
        @respuesta = recibe

        @envia.join
        @respuesta.join
    end

    def envia
        puts "Por favor registrate con |=REGISTRO:"
        begin
           Thread.new do
           loop do
               message = $stdin.gets.chomp
               @socket.puts message
            end
        end
        rescue IOError => e
            puts e.message
            @socket.close
        end
    end

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
      puts e.message
      @socket.close
      end
    end

end


#socket = TCPSocket.open( "localhost", 8080 )
#Cliente.new(socket)
