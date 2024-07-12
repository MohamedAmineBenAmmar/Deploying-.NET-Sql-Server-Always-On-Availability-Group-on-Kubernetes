#!/bin/bash

# Run the primary sql script
sqlcmd -S localhost,1433 -U sa -P "Welcome@0001234567" -i primary.sql

# save the pod names for primary, secondary in variables
podagp=$(kubectl get pods -l app=mssql-primary -o json -n mssql | jq -r '.items[0].metadata.name')
podags=$(kubectl get pods -l app=mssql-secondary -o json -n mssql | jq -r '.items[0].metadata.name')


#set the paths to the certificate and the key yo a variable
PathToCopyCert=${podagp}":var/opt/mssql/ag_certificate.cert"
PathToCopyCertKey=${podagp}":var/opt/mssql/ag_certificate.key"

# First copy to local
kubectl -n mssql cp $PathToCopyCert ./tmp/ag_certificate.cert
kubectl -n mssql cp $PathToCopyCertKey ./tmp/ag_certificate.key

# Copy the certificate from local host to secondary1

kubectl -n mssql cp ./tmp/ag_certificate.cert  $podags:var/opt/mssql
kubectl -n mssql cp ./tmp/ag_certificate.key  $podags:var/opt/mssql

# Run the secondary sql script
sqlcmd -S localhost,1432 -U sa -P "Welcome@0001234567" -i secondary.sql
