package org.apache.camel.example;

import org.apache.camel.example.createticket.OutputCreateTicket;
import org.apache.camel.example.reportincident.OutputReportIncident;


public class PostProcessor {

    public OutputReportIncident prepare(OutputCreateTicket input) {
        System.out.println("Creating incident report" + input);
        OutputReportIncident ok = new OutputReportIncident();
        ok.setCode("OK" + input.getCode());
        return ok;
    }

}
