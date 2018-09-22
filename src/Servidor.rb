# coding: utf-8
require 'socket'
require './Sala'
require './Protocolo'
require './Status'

class Servidor

    #Constructor para la clase Servidor.
    #Parametro socket_address: la dirección para abrir el socket del puerto.
    #Parametro socket_port: El puerto por el cual el servidor va transmitir/recibir información.
    def initialize(socket_address, socket_port)
        @socketServidor = TCPServer.open( socket_port , socket_address )
        @detalles = Hash.new()
        @clientes = Hash.new()
        @salas = Hash.new()
        @conectados = 0
        @detalles[:cliente] = @clientes
        @detalles[:servidor] = @socketServidor
        @detalles[:salas] = @salas
        @detalles[:salas]["mainSala"] = Sala.new("Master", nil)
        corre()
    end

    #Método corre de la clase servidor recibe las conexiones e instancia un hilo por cada
    #conexión que recibe y lee las cadenas que ésta envía para ejecutar el protocolo.
    def corre()
        puts "Iniciando Servidor..."
        loop do
            cliente = @socketServidor.accept
            Thread.start(cliente) do |conexion|
                 puts "Se ha detectado un cliente, procediendo al protocolo de conexión"
                 nombre = registra(cliente)
                 @detalles[:salas]["mainSala"].unirse(cliente)
                 cliente.puts "Registrate en una sala con \"CREATEROOM\" o accede a una con \"JOINROOM\""
                 lector(cliente, nombre)
            end
        end
    end

    #Parámetro cliente: la conexión recibida por el método corre() que establece
    #la transmisión y recepción de los mensajes en particular (cadenas de bytes)
    #Pide al cliente que se identifique con el protocolo IDENTIFY y revisa que su nombre
    #no esté contenido en el diccionario de clientes, si ya está salta una advertencia y
    #te pide que te registres de nuevo hasta que el nombre introducido sea uno nuevo.
    def registra(cliente)
        #salir(cliente)
        cadena = cliente.gets.chomp
        if cadena.include? "IDENTIFY "
            cadena.slice! "IDENTIFY "
            if @detalles[:cliente][cadena] != nil
                cliente.puts "ya hay un usuario registrado con ese nombre"
                registra(cliente)
                #cliente.kill self
            else
                clientecito = Array.new(3)
                clientecito[0] = cliente
                clientecito[1] = Status::ACTIVE
                clientecito[2] = cadena
                @detalles[:cliente][cadena] = clientecito
                cliente.puts "el registro fue exitoso"
                return cadena
            end
        end
        cliente.puts "Usa el protocolo \"IDENTIFY\" seguido de tu nombre."
        registra(cliente)
    end

    #Parámetro cadena: el mensaje recibido por la conexión
    #Parámetro cliente: la conexión para establecer la transferencia/recepción de bytes
    #revisa que compla con el protocolo JOINROOM ó CREATEROOM, y corta la cadena para obtener
    #el nombre. Revisa que el nombre sea nuevo en el diccionario de salas y lo agrega, caso
    #contrario salta una advertencia y regresa al método lector()
    def meteSala(cadena, cliente)
        puts cadena
        if cadena.include? "JOINROOM "
            cadena.slice! "JOINROOM "
            if @detalles[:salas][cadena] != nil
                @detalles[:salas][cadena].unirse(cliente)
                puts "#{cliente} se unió a la sala #{cadena}"
                cliente.puts "te has unido a la sala #{cadena}"
                return
            end
        elsif cadena.include? "CREATEROOM "
                cadena.slice! "CREATEROOM "
                puts cadena
                if !(@detalles[:salas][cadena] != nil)
                    @detalles[:salas][cadena] = Sala.new(cadena, cliente)
                    @detalles[:salas][cadena].unirse(cliente)
                    cliente.puts "se ha creado la sala #{cadena}"
                    puts "#{cliente} ha creado la sala #{cadena}"
                    return
                end
            end
        cliente.puts "algo salió mal tratando de crear o unirte a una sala, intentalo de nevo"
        return
    end


    #Parámetro cliente: la conexión para la transferencia/recepción de bytes
    #Parámetro nombre: la cadena con el nombre de la asociado a la conexión
    #El lector es un ciclo que recibe las cadenas de bytes del cliente y las manda al
    #método procesa() que verificará que los mensajes respeten el protocolo.
    def lector(cliente, nombre)
        loop do
          mensaje = cliente.gets.chomp
          procesa(mensaje, cliente, nombre)
        end
    end

    #Parámetro usuario: el nombre asociado a la conexión del cliente
    #Parámetro cliente: la conexión para transmitir/recibir cadenas de bytes
    #Parámetro sala: el nombre de la sala a la que los mensajes se distribuirán
    #Parámetro mensaje: la cadena recibida del cliente con el nombre de la sala y el mensaje
    #Distribuye el mensaje recibido en la sala recibida, si no está en el diccionario de salas
    #no envía el mensaje evidentemente.
    def chat(usuario, cliente, sala, mensaje)
        tiempo = Time.new
        puts mensaje
        salon = @detalles[:salas][sala]
        salon.clientes().keys.each do |amigos|
            salon.clientes()[amigos].puts "#{tiempo.inspect} #{usuario} #{sala}: #{mensaje}"
            puts "a las:#{tiempo.inspect} usuario:#{usuario}: dijo:#{mensaje}"
          end
    end

    #Parámetro solicitadr: la conexión del cliente que pide le transmitan la lista de usuarios
    #recorre el diccionario de clientes e imprime en pantalla el nombre de cada uno
    def usuarios(solicitador)
        @detalles[:cliente].keys.each do |client|
            solicitador.puts client
        end
    end

    #Parámetro mensaje: el mensaje con el status a cambiar
    #Parámetro cliente: la conexión del cliente para transmitir/recibir bytes
    #Parámetro usuario: el nombre asociado a la conexión del cliente.
    #Busca la cadena usuario en el diccionario de clientes y cambia su estatus.
    def cambiarStatus(mensaje, cliente, usuario)
        if @detalles[:cliente][usuario] != nil
            clientecito = @detalles[:cliente][usuario]
        end
        if mensaje.includes? "ACTIVE"
              clientecito[1] = Status::AWAY
        elsif mensaje.includes? "BUSSY"
              clientecito[1] = Status::AWAY
        elsif mensaje.includes? "AWAY"
              clientecito[1] = Status::AWAY
        else
              cliente.puts "el comando está incompleto intenta de nuevo"
              return
        end
    end


    #Parámetro mensaje: el mensaje con el nombre y la sala de la persona a invitar
    #Parámetro usuario: el nombre de la conexión que envía la invitación
    #busca el nombre y la sala en sus respectivos diccionarios, si están contenidos ambos al mismo tiempo
    #envía la invitación
    def invitar(mensaje, usuario)
        arreglo = mensaje.split
        if @detalles[:salas][arreglo[0]] != nil && @detalles[:cliente][arreglo[1]] != nil
            @detalles[:cliente][arreglo[1]].puts "#{usuario} te invitó a la sala #{arreglo[0]}"
        end
    end

    #Parámetro mensaje: el mensaje con la sala y el mensaje a trasmitir
    #Parámetro cliente: la conexión para transmitir/recibir bytes
    #Parámetro usuario: el nombre asociado a la conexión
    #Corta la cadena y la mete a un arreglo, retira el primero argumento
    #busca el primer argumento en el diccionario de salas y si está contenido
    #utilia la función chat para transmitir el mensaje en esa sala.
    def getMensajeSala(mensaje, cliente, usuario)
       arreglo = mensaje.split(" ")
       if @detalles[:salas][arreglo[0]] != nil
          sala = arreglo[0]
          arreglo.delete_at(0)
          mensaje = arreglo.join(" ")
          chat(usuario, cliente, sala, mensaje)
        end
    end

    #Parámetro chango: la conexión a desconectar
    #Parámetro usiario: el nombre asociado a la conexió.
    def desconectar(chango, usuario)
        @detalles[:cliente][usuario] = nil
        chango.puts "te voy a desconectar men"
        chango.close
    end

    #Parámetro mensaje: el mensaje a procesar para ver si cumple con el protocolo
    #Parámetro cliente: la conexión para transmitir/recibir bytes
    #Parámetro usuario: el nombre asociado a la conexión
    def procesa(mensaje, cliente, usuario)
       if mensaje.include? "CREATEROOM "
           meteSala(mensaje, cliente)
       elsif mensaje.include? "JOINROOM "
           meteSala(mensaje, cliente)
       elsif mensaje.include? "USERS "
           usuarios(cliente)
       elsif mensaje.include? "STATUS "
           mensaje.slice! "STATUS "
           cambiarStatus(mensaje, cliente, usuario)
       elsif mensaje.include? "INVITE "
           mensaje.slice! "INVITE "
           invitar(mensaje, usuario)
       elsif mensaje.include? "ROOMESSAGE "
           mensaje.slice! "ROOMESSAGE "
           cliente.puts mensaje
           getMensajeSala(mensaje, cliente, usuario)
      elsif mensaje.include? "PUBLICMESSAGE "
             mensaje.slice! "PUBLICMESSAGE "
             chat(usuario, cliente, "mainSala", mensaje)
       elsif mensaje.include? "DISCONNECT "
           desconectar(cliente, usuario)
       else
           cliente.puts "ingresa una cadena válida porfa"
       end
    end

end
