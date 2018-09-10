# coding: utf-8
require 'socket'
require './Sala'

class Servidor

    def initialize(socket_address, socket_port)
        @socketServidor = TCPServer.open( socket_port , socket_address )
        @clientes = Hash.new
        @salas = Hash.new()
        @conectados = 0
        @detalles = Hash.new
        @detalles[:cliente] = @clientes
        @detalles[:servidor] = @socketServidor
        @detalles[:salas] = @salas
        corre()
    end

    def corre()
        puts "Iniciando Servidor..."
        loop do
            cliente = @socketServidor.accept
            Thread.start(cliente) do |conexion|
                 puts "Se ha detectado un cliente, procediendo al protocolo de conexión."
                 nombre = registra(cliente)
                 cliente.puts "Registrate en una sala con |=SALA:"
                 salita = meteSala(cliente)
                 puts "Iniciando sala de chat."
                 cliente.puts "Iniciando la sala de chat #{salita}"
                 chat(nombre, cliente, salita)
            end
        end
    end


    def registra(cliente)
        cadena = cliente.gets.chomp
        manejador(cadena, cliente, "")
        if cadena.include? "|=REGISTRO:"
            cadena.slice! "|=REGISTRO:"
            if @detalles[:cliente][cadena.to_sym] != nil
                cliente.puts "ya hay un usuario registrado con ese nombre"
                registra(cliente)
                #cliente.kill self
            else
                @detalles[:cliente][cadena.to_sym] = cliente
                return cadena
                conectados += 1
            end
        else
            cliente.puts "Usa el protocolo |=REGISTRO: seguido de tu nombre."
            registra(cliente)
        end
    end

    def meteSala(cliente)
        cadena = cliente.gets.chomp
        manejador(cadena, cliente, "")
        if cadena.include? "|=SALA:"
            cadena.slice! "|=SALA:"
            if @detalles[:salas][cadena] != nil
                @detalles[:salas][cadena].unirse(cliente)
                puts "#{cliente} se unió a la sala #{cadena}"
                cliente.puts "te has unido a la sala #{cadena}"
                return cadena
            else
                @detalles[:salas][cadena] = Sala.new("cadena")
                @detalles[:salas][cadena].unirse(cliente)
                cliente.puts "se ha creado la sala #{cadena}"
                puts "#{cliente} ha creado la sala #{cadena}"
                return cadena
            end
        else
            cliente.puts "Usa el protocolo |=SALA: seguido del nombre de la sala."
            meteSala(cadena, cliente, salita)
        end
    end

    def chat(usuario, cliente, sala)
        tiempo = Time.new
        loop do
        mensaje = cliente.gets.chomp
        manejador(mensaje, cliente, sala)
        salon = @detalles[:salas][sala]
        salon.clientes().keys.each do |amigos|
            salon.clientes()[amigos].puts "#{tiempo.inspect} #{usuario}: #{mensaje}"
            puts "a las:#{tiempo.inspect} usuario:#{usuario}: dijo:#{mensaje}"
            end
        end
    end

    def manejador(mensaje, cliente, sala)
      if mensaje.include? "|=SALIR:"
          mensaje.slice! "|=SALIR:"
          salon = @detalles[:salas][mensaje]
          if salon != nil
             salon.dejar(cliente)
          end
      else if mensaje.include? "|=DESCONECTAR:"
          puts "#{cliente} solicitó desconectarse"
          cliente.puts "desconectando del servidor"
          cliente.close
      end
    end
end
end

#Servidor.new(8080,"localhost") 
