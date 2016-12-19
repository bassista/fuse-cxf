package org.apache.camel.example;

import java.math.BigInteger;
import org.apache.camel.example.createticket.InputCreateTicket;
import org.apache.camel.example.createticket.OutputCreateTicket;

public class TicketServer {
    private static long ticketId;

    public OutputCreateTicket registerTicket(InputCreateTicket input) {

        System.out.println("Creating ticket for" + input.getSummary());
        OutputCreateTicket ok = new OutputCreateTicket();
        ok.setCode(BigInteger.valueOf(++ticketId));
        return ok;
    }

}
