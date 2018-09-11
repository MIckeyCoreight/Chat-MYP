# coding: utf-8
require 'socket'
require './Sala'
require './Protocolo'
require './Status'

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
                 cliente.puts "Registrate en una sala con \"CREATEROOM\""
                 salita = meteSala(cliente)
                 puts "Iniciando sala de chat."
                 cliente.puts "Iniciando la sala de chat #{salita}"
                 chat(nombre, cliente, salita)
            end
        end
    end


    def registra(cliente)
        #salir(cliente)
        cadena = cliente.gets.chomp
        if cadena.include? "IDENTIFY "
            cadena.slice! "IDENTIFY "
            if @detalles[:cliente][cadena.to_sym] != nil
                cliente.puts "ya hay un usuario registrado con ese nombre"
                registra(cliente)
                #cliente.kill self
            else
                @detalles[:cliente][cadena.to_sym] = cliente
                return cadena
            end
        else
            cliente.puts "Usa el protocolo \"IDENTIFY\" seguido de tu nombre."
            registra(cliente)
        end
    end

    def meteSala(cliente)
        cadena = cliente.gets.chomp
        puts cadena
        if cadena.include? "JOINROOM "
            cadena.slice! "JOINROOM "
            puts "heblo1 "
            #if @detalles[:salas][cadena] != nil
                @detalles[:salas][cadena].unirse(cliente)
                puts "#{cliente} se unió a la sala #{cadena}"
                cliente.puts "te has unido a la sala #{cadena}"
                return cadena
            #end
        elsif cadena.include? "CREATEROOM "
                puts "heblo"
                cadena.slice! "CREATEROOM "
                puts cadena
                if !(@detalles[:salas][cadena] != nil)
                    @detalles[:salas][cadena] = Sala.new(cadena, cliente)
                    @detalles[:salas][cadena].unirse(cliente)
                    cliente.puts "se ha creado la sala #{cadena}"
                    puts "#{cliente} ha creado la sala #{cadena}"
                    return cadena
                end
            end
        cliente.puts "Usa JOINROOM O CREATEROOM : seguido del nombre de la sala."
        meteSala(cadena, cliente, salita)
    end

    def chat(usuario, cliente, sala)
        tiempo = Time.new
        loop do
        mensaje = cliente.gets.chomp
        puts mensaje
        #puts @detalles[:salas][sala]
        salon = @detalles[:salas][sala]
        #puts @detalles[:salas][sala]
        salon.clientes().keys.each do |amigos|
            salon.clientes()[amigos].puts "#{tiempo.inspect} #{usuario}: #{mensaje}"
            puts "a las:#{tiempo.inspect} usuario:#{usuario}: dijo:#{mensaje}"
            end
        end
    end

    def procesa(mensaje)
    end

end

#Servidor.new(8080,"localhost")
