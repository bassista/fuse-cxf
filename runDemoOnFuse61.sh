
#fabric:profile-edit --pid io.fabric8.agent/org.ops4j.pax.url.mvn.repositories='file:/home/bibryam/projects/fuse-cxf/offline-repo/target/repo@snapshots@id=bp' default

fabric:profile-edit --repositories mvn:com.ofbizian/features/1.0.0/xml/features default

fabric:profile-create --parents feature-camel demo-profile

container-create-child root demo-container

container-add-profile demo-container demo-profile

fabric:version-create --parent 1.0 --default 1.1

fabric:profile-edit --features camel-routes-demo demo-profile 1.1

container-upgrade --all 1.1

log:tail


