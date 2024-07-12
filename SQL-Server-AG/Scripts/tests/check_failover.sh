#!/bin/bash

echo "Check if the secondary replica is ready for failover"
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "
SELECT is_failover_ready
FROM sys.dm_hadr_database_replica_cluster_states
WHERE replica_id = (SELECT replica_id FROM sys.availability_replicas WHERE replica_server_name = 'mssql-secondary-statefulset-0')
" -y 30 -Y 30
echo
