export CLUSTER_NAME="sdlc-kafka"
export PASSWORD="creds"
openssl genrsa -out ca.key 2048
openssl req -x509 -sha256 -new -nodes -key ca.key -days 3650 -out ca.crt -config openssl.cnf

openssl pkcs12 -export -in ca.crt -nokeys -out ca.p12 -password pass:${PASSWORD} -caname ca.crt

kubectl create secret generic ${CLUSTER_NAME}-clients-ca-cert --from-file=ca.crt=ca.crt
kubectl create secret generic ${CLUSTER_NAME}-cluster-ca-cert \
  --from-file=ca.crt=ca.crt \
  --from-file=ca.p12=ca.p12 \
  --from-literal=ca.password=${PASSWORD}

kubectl create secret generic ${CLUSTER_NAME}-clients-ca --from-file=ca.key=ca.key
kubectl create secret generic ${CLUSTER_NAME}-cluster-ca --from-file=ca.key=ca.key

kubectl label secret ${CLUSTER_NAME}-clients-ca-cert strimzi.io/kind=Kafka strimzi.io/cluster="${CLUSTER_NAME}"
kubectl label secret ${CLUSTER_NAME}-cluster-ca-cert strimzi.io/kind=Kafka strimzi.io/cluster="${CLUSTER_NAME}"
kubectl label secret ${CLUSTER_NAME}-clients-ca strimzi.io/kind=Kafka strimzi.io/cluster="${CLUSTER_NAME}"
kubectl label secret ${CLUSTER_NAME}-cluster-ca strimzi.io/kind=Kafka strimzi.io/cluster="${CLUSTER_NAME}"

kubectl annotate secret ${CLUSTER_NAME}-clients-ca-cert strimzi.io/ca-cert-generation="0"
kubectl annotate secret ${CLUSTER_NAME}-cluster-ca-cert strimzi.io/ca-cert-generation="0"
kubectl annotate secret ${CLUSTER_NAME}-clients-ca strimzi.io/ca-key-generation="0"
kubectl annotate secret ${CLUSTER_NAME}-cluster-ca strimzi.io/ca-key-generation="0"
