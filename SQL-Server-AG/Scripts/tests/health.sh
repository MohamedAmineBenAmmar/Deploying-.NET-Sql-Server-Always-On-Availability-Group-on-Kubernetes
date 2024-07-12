#!/bin/bash

echo "Checking the availability group components by querying the dynamic management view (DMV)."
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "select * from sys.dm_hadr_availability_replica_cluster_nodes" -y 30 -Y 30
echo

echo "Collect local database replica states"
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "
SELECT cs.[database_name], 'database_replica', rs.synchronization_health
FROM sys.dm_hadr_database_replica_states rs
join sys.dm_hadr_database_replica_cluster_states cs ON rs.replica_id = cs.replica_id and rs.group_database_id = cs.group_database_id
WHERE rs.is_local = 1
" -y 30 -Y 30
echo

echo "query the overall synchronization health of the availability group K8sAG"
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "
SELECT ag.[name], 'availability_group', gs.synchronization_health
FROM sys.dm_hadr_availability_group_states gs
join sys.availability_groups_cluster ag ON gs.group_id = ag.group_id
WHERE gs.primary_replica = 'mssql-primary-statefulset-0'
" -y 30 -Y 30
echo "This query produces the below output indicating that the AG named K8sAG is replicated to 2 replicas as configured."
echo

echo "Get information about configured replicas"
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "
Select replica_server_name, endpoint_url, availability_mode_desc from sys.availability_replicas
" -y 30 -Y 30
echo




