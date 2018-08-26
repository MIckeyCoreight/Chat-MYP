require 'socket'

class Servidor

  def intiliaze()
      @servidor = TCPServer( 2000 , "localhost" )
      @clientes = hash.new
      @salas = hash.new
      @conectados = 0
      @contadorSalas = 0
      @conexiones = hash.new
      conexiones[:cliente] = @clientes
      conexiones[:salas] = @salas
      conexiones[:servidor] = @servidor
      iniciar()
  end

  def getConexiones
      return @conexiones
  end

  def getSalas
      return @salas
  end

  def getClientes
       return @clientes
  end

  def creaSala(sala, socket)
      if salas[sala] != nil
        socket.puts "Sala ya existe"
      else
        salas[sala] = hash.new 
      end 
  end  

  def unirseSala(usuario , sala)
    if salas[sala] != nil
      sala[sala][:cliente] = usuario
    else
      puts "no se pudo unir a la sala"
    end
  end

  def registro(usuario)
    if conexiones[:cliente][usuario] != nil
      puts "el cliente ya existe"
    else
      conexiones[:cliente][usuario] = ususario
  end  
  
end  
