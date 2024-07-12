#!/bin/bash

echo "After the failover the primary is down and not synchronizing"
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "
SELECT ag.[name], 'availability_group', gs.synchronization_health
FROM sys.dm_hadr_availability_group_states gs
join sys.availability_groups_cluster ag ON gs.group_id = ag.group_id
WHERE gs.primary_replica = 'mssql-primary-statefulset-0'
" -y 30 -Y 30
echo


echo "After the failover the secondary is down and not synchronizing"
sqlcmd -S localhost,1432 -U sa -P "Welcome@0001234567" -Q "
SELECT ag.[name], 'availability_group', gs.synchronization_health
FROM sys.dm_hadr_availability_group_states gs
join sys.availability_groups_cluster ag ON gs.group_id = ag.group_id
WHERE gs.primary_replica = 'mssql-primary-statefulset-0'
" -y 30 -Y 30
echo "The secondary is also now in read/write mode."
echo



