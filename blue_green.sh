#!/bin/sh

jps -lm | grep karaf | grep -v grep | awk '{print $1}' | xargs kill -KILL

export FUSE_INSTALL_PATH=`pwd`
rm -rf ${FUSE_INSTALL_PATH}/data
rm -rf ${FUSE_INSTALL_PATH}/instances
sed -i 's/#admin/admin/' ${FUSE_INSTALL_PATH}/etc/users.properties
cd ${FUSE_INSTALL_PATH}/bin/
./start

sleep 20
./client

wait-for-service -t 300000 io.fabric8.api.BootstrapComplete

fabric:create --wait-for-provisioning --profile fabric

fabric:version-create
fabric:patch-apply --version 1.1 file:///Users/bibryam/Downloads/jboss-fuse-6.2.1.redhat-186-03-r7hf3.zip
fabric:container-upgrade -all 1.1

fabric:profile-edit --repositories mvn:com.ofbizian/features/1.0.0/xml/features default
fabric:profile-edit --pid io.fabric8.gateway.http/port=\${port:9000,9010} gateway-http
fabric:profile-edit --pid io.fabric8.gateway.http/immediateUpdate=true gateway-http
fabric:profile-edit --pid io.fabric8.gateway.http.mapping-servlets/uriTemplate={contextPath}/ gateway-http

# deploy ticket service
fabric:profile-create --parents feature-camel ticket-profile
container-create-child root ticket-container
container-add-profile ticket-container ticket-profile
fabric:profile-edit --features ticket-service ticket-profile

# deploy incident service
fabric:profile-create --parents feature-camel incident-profile
container-create-child root incident-container
container-add-profile incident-container incident-profile
fabric:profile-edit --features incident-service incident-profile

#try services (port may vary)
#http://localhost:8183/cxf/camel-example-cxf-blueprint/webservices/ticket?wsdl
#http://localhost:8184/cxf/camel-example-cxf-blueprint/webservices/incident?wsdl

# create gateways
container-create-child root gateway1
container-add-profile gateway1 gateway-http

container-create-child root gateway2
container-add-profile gateway2 gateway-http

# create gateway that will serve only version 1.1 services
container-create-child root gateway3
container-add-profile gateway3 gateway-http
fabric:profile-create --parents gateway-http gateway3-profile
container-add-profile gateway3 gateway3-profile
fabric:profile-edit --pid io.fabric8.gateway.http/enabledVersion=1.1 gateway3-profile

#try gateways (port may vary)
#http://localhost:9000/cxf/
#http://localhost:9001/cxf/
#http://localhost:9002/cxf/


fabric:version-create
fabric:container-upgrade ticket-container 1.2
fabric:container-upgrade gateway1 1.2
fabric:container-upgrade gateway3 1.2



-------------
Expectations

1. gateway1 serves ticket-container as both are version 1.2
2. gateway2 serves incident-container as both are version 1.1
3. gateway3 serves incident-container as gateway3 is configured to serve services in version 1.1 such as incident-container
