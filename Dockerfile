FROM solr:6.6.2

LABEL MAINTAINER sharpslinger

WORKDIR /opt/solr/server/etc

COPY solrinitcfg solrinitcfg

RUN mv solrinitcfg /opt/solr/bin

RUN cat /opt/solr/bin/solrinitcfg  >> /opt/solr/bin/solr.in.sh

RUN keytool -genkeypair -alias solr-ssl -keyalg RSA \
    -keysize 2048 -keypass secret -storepass secret -validity 9999 \
    -keystore solr-ssl.keystore.jks -ext SAN=DNS:solr \
    -dname "CN=solr, OU=Development, O=Intouch, L=Overland Park, ST=KS, C=US" \
    -noprompt

RUN keytool -importkeystore \
    -srckeystore solr-ssl.keystore.jks -destkeystore solr-ssl.keystore.p12 \
    -srcstoretype JKS -deststoretype PKCS12 \
    -srckeypass secret -srcstorepass secret -destkeypass secret -deststorepass secret \
    -srcalias solr-ssl -destalias docker-solr -noprompt

CMD ["-force"]

EXPOSE 8983