# coding: utf-8
require 'socket'
require './Sala'

class Servidor

    def intiliaze()
        @servidor = TCPServer( 2000 , "localhost" )
        @clientes = Hash.new
        @salas = Hash.new()
        @conectados = 0
        @detalles = Hash.new
        detalles[:cliente] = @clientes
        detalles[:servidor] = @servidor
        detalles[:salas] = @salas
        servidor()
    end 

    def servidor()
        loop{
            cliente = servidor.accept
            Thread.start(cliente) do |conexion|
              if registra(cliente)
                 nombre = registra(cliente)
                 chat(nombre, cliente)
              else
                conexion.kill self
              end  
            end
            
        }.join
     end

  
    def registra(cliente)
      #salir(cliente)
      cadena = cliente.gets.chomp
      if cadena.include? "|=REGISTRO:"
         cadena.slice! "|=REGISTRO:"
         if @detalles[:cliente][cadena.to_sym] != nil
            cliente.puts "ya hay un usuario registrado con ese nombre"
            registra(cliente)
         else
            @detalles[:cliente][cadena.to_sym] = cliente
            return cadena
         end
      end   
    end

    def meteSala(cadena, cliente)
        if cadena.include? "|=SALA:"
           cadena.slice! "|=SALA:"
           if @detalles[:salas][cadena] != nil
              @detalles[:salas][cadena].clientes()[cliente] = cliente 
           else
             @detalles[:salas][cadena] = Sala.new("cadena")
             @detalles[:salas][cadena].clientes()[cliente] = cliente
           return cadena  
           end
           #si llegaste a este punto mamaste, el programa no sirve :( arréglalo
        end
    end

    def chat(usuario, cliente)
      mensaje = socket.gets.chomp
      sala = meteSala(mensaje, cliente)
      time 1 = Time.new
      loop{
        mensaje = socket.gets.chomp
        puts @detalles[:salas][sala]
        (@detalles[:salas][sala].clientes()).keyes.each do |amigos|
            @detalles[:salas][sala].clientes[amigos].puts "#{time1.inspect} #{usuario}: #{mensaje}" 
        end
      }
    end
 
  
end  
