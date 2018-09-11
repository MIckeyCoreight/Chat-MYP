class Protocolo
    
        IDENTIFY = 1
        USERS = 2
        MESSAGE = 3
        PUBLICMESSAGE = 4
        CREATEROOM = 5
        INVITE = 6
        JOINROOM = 7
        ROOMESSAGE = 8
        DISCONNECT = 9

    def toString(numero)
        case numero
        when 1
            return "IDENTIFY"
        when 2
            return "USERS"
        when 3
            return "MESSAGE"
        when 4
            return "PUBLICMESSAGE"
        when 5
            return "CREATEROOM"
        when 6
            return "INVITE"
        when 7
            return "JOINROOM"
        when 8
            return "ROOMESSAGE"
        when 9
            return "DISCONNECT"
        end
    end

end
