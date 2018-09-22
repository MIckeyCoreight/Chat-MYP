require 'socket'
require_relative './Servidor'
require_relative './Cliente'
require_relative './Status'
require_relative './Protocolo'

class Chat

    #Constructor de la clase chat
    #únicamente manda a llamar la función queHacer()
    def initialize()
        queHacer()
    end

    #Instancia el servidor o el cliente dependiendo de lo que escriba el usuario en la consola
    def queHacer()
        puts "Escribe \"servidor\" si quieres iniciar un servidor \n"
        puts "Escribe \"cliente\" si quieres instanciar un cliente \n"
        cadena = $stdin.gets.chomp
        if cadena.eql? "servidor"
           construyeServidor()
        elsif cadena.eql? "cliente"
           construyeCliente()
        else
            puts "te pedí que la entrada fuera el \"servidor\" o \"cliente\", necio \n"
            puts "vuelve a intentarlo hasta que hagas lo que te pido UnU. \n \n"
            queHacer()
        end
    end

    #Pide que metas el puerto y direcciónm para crear una instancia de la clase cliente
    def construyeCliente()
        begin
        puts "indica el puerto para conectarte al servidor"
        puerto = $stdin.gets.chomp
        puts "indica la direccion para conectarte al servidor"
        direccion = $stdin.gets.chomp
        Cliente.new(puerto, direccion)
        rescue SocketError => e
            puts e.message
            puts "el servidor no existe"
        end
    end

    #Pide que metas el puerto y direcciónm para crear una instancia de la clase cliente
    def construyeServidor()
        begin
        puts "indica el puerto para el servidor:"
        puerto = $stdin.gets.chomp
        puts "indica la direccion para el servidor"
        direccion = $stdin.gets.chomp
        Servidor.new(puerto, direccion)
        rescue SocketError => e
            puts e.message
            puts "el servidor no existe"
        end
    end


end

chat = Chat.new()
