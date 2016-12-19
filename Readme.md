#### Fuse CXF Proxy Demo

#####A simple Camel CXF Proxy demo consisting of two parts:  
  * Ticket service: a Camel route with CXF endpoint that returns ticket new IDs.  
  * Incident service: a Camel route with CXF endpoint that proxies SOAP calls to ticket service and returns the result.  

#####The project also contains:  
  * Features   
  * Offline repo  
  * Script to deploy all into Fuse 6.1      

#####Links to chemas
  * http://localhost:8181/cxf/camel-example-cxf-blueprint/webservices/ticket?wsdl         
  * http://localhost:8181/cxf/camel-example-cxf-blueprint/webservices/incident?wsdl
  