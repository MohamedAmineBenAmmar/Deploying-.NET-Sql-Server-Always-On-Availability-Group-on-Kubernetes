#!/bin/bash

echo "Query the DMV to get metrics on the wait time."
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -Q "SELECT * FROM sys.dm_os_wait_stats WHERE wait_type = 'HADR_SYNC_COMMIT';" -y 30 -Y 30
echo



