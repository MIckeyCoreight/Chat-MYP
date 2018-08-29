require 'socket'

class Servidor

  def intiliaze()
      @servidor = TCPServer( 2000 , "localhost" )
      @clientes = Hash.new
      @salas = Hash.new
      @conectados = 0
      @contadorSalas = 0
      @conexiones = Hash.new
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

 
  end

  def registro(usuario)
    if conexiones[:cliente][usuario] != nil
      puts "el cliente ya existe"
    else
      conexiones[:cliente][usuario] = ususario
  end  
  
end  
