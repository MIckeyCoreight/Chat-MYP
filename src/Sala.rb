# coding: utf-8


class Sala

    def initialize(nombre)
        @clientes = Hash.new #hash que va a contener a los Socket
        @poblacion = 0
        @nombre = nombre
    end

    def clientes()
	      return @clientes
    end

    def poblacion()
	      return @poblacion
    end

    def nombre()
	      return @nombre
    end

    def unirse(cliente)
        if @clientes[cliente] == nil
		      	@clientes[cliente] = cliente
				  	@poblacion = @poblacion + 1
			  end
    end

    def dejar(cliente)
        if @clientes[cliente] != nil
            @clientes.delete(:cliente)
            @poblacion = @poblacion - 1
        else
            cliente.puts "no perteneces a esta sala"
        end
    end
end
