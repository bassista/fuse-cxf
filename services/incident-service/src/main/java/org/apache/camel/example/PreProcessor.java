package org.apache.camel.example;

import org.apache.camel.example.createticket.InputCreateTicket;
import org.apache.camel.example.reportincident.InputReportIncident;

public class PreProcessor {
    public InputCreateTicket prepare(InputReportIncident input) {
        System.out.println("SSSS" + input);
        InputCreateTicket ok = new InputCreateTicket();
        ok.setSummary(input.getSummary());
        return ok;
    }
}
