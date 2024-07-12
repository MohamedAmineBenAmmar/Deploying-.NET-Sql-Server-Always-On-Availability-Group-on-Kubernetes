#!/bin/bash

echo "Performing the failover"
sqlcmd -S localhost,1432 -U sa -P "Welcome@0001234567" -Q "
ALTER AVAILABILITY GROUP K8sAG  FORCE_FAILOVER_ALLOW_DATA_LOSS
" -y 30 -Y 30
echo "Failover done successfully"


