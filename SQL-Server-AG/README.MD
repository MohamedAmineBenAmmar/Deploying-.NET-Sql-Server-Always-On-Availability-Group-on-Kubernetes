# How to determine the name of the server within the pod of the K8S cluster ?
- Run: SELECT @@SERVERNAME AS 'Current Server Name';
=> This is going to help to correctly identify the name of the server to be configured in the CREATE AVAILABILITY GROUP [K8sAG] ... section of the primary.sql script

# To test if the database is reachable using the K8S DNS resolution
kubectl port-forward svc/mssql-primary-service 5000:1433 -n mssql
sqlcmd -S 127.0.0.1,5000 -U sa -P "Welcome@0001234567" -Q "select * from sys.dm_hadr_availability_replica_cluster_nodes" -y 30 -Y 30
=> Success