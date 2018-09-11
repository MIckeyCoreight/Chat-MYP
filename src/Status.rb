class Status

   ACTIVE = 1
   AWAY = 2
   BUSSY = 3

   def toString(numero)
       case numero
       when 1
           return "ACTIVE"
        when 2
            return "AWAY"
        when 3
            return "BUSSY"
        end            
   end

end
