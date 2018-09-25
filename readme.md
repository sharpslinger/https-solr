# Solr for Sitecore
This creates a docker container with a security certificate, since the Sitecore Installation Framework requires an https connection to Solr.

### Pull the image
`docker run sharpslinger/https-solr:latest`

`docker ps -a` (get the container ID or a unique prefix; in the case of 0683b865494b you can shorten to 0683)

### Export the generated certificate
if running Windows/Hyper-V containers the container has to be stopped
```docker stop 0683```

```docker cp 0683:/opt/solr/server/etc/solr-ssl.keystore.p12 C:\Code\docker-development\certs```

### Install the certificate
Install the exported certificate into your Trusted Root Certification Authorities store
Add a `127.0.0.1 solr` to your hosts file

### Run it!
Restart the container and navigate to https://solr:8983/solr