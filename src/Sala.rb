# coding: utf-8


class Sala

  #Constructor único para la clase sala
  #Parámetro nombre: el nombre de la Sala
  #Parámetro dueño: el cliente que declara la sala
  def initialize(nombre, dueño)
      @clientes = Hash.new #hash que va a contener a los Socket
      @poblacion = 0
		  @dueño = dueño
      @nombre = nombre
  end

  #Regresa la variable @clientes
  def clientes()
	    return @clientes
  end

  #Regresa la variable @población
  def poblacion()
	    return @poblacion
  end

  #Regresa la variable @dueño
	def dueño()
		  return @dueño
	end

  #Regresa la variable @nombre
  def nombre()
	    return @nombre
  end

  #Parámetro cliente: el cliente a agregar a la sala
  #Revisa que el cliente no esté contenido en el diccionario de clientes
  #caso contrario agrega el cliente al diccionario
  def unirse(cliente)
      if @clientes[cliente] != nil
          return
      else
          @clientes[cliente] = cliente
          @poblacion += 1
      end
  end

  #Parámetro cliente: el cliente a eliminar de la sala
  #busca el cliente en el diccionario de clientes, si no está contenido
  #no hace nada, en otro caso lo elimina
  def dejar(cliente)
      if @clientes[cliente] != nil
          @clientes.delete(:cliente)
      else
          cliente.puts "no perteneces a esta sala"
      end
  end

end
