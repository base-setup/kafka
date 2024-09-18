0. For debug 

```
kubectl run -it --rm dnsutil --image tutum/dnsutils
```

1. [custom CA](https://strimzi.io/docs/operators/in-development/full/deploying.html#proc-replacing-your-own-private-keys-str)

2. [configure Keycloak](https://strimzi.io/docs/operators/in-development/full/deploying.html#assembly-oauth-authentication_str)
- create client secret
- use custom CA on keycloak

3. [Detailed information about debezium PostgreSQL Connector](https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-required-configuration-properties)  
4. Set postgres `ALTER SYSTEM SET wal_level = logical;` for `KafkaConnector`
Can be done on system start! [Off doc](https://www.postgresql.org/docs/current/runtime-config-wal.html)
