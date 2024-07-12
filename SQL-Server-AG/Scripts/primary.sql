-- Create AG test database
USE [master]
GO
USE [AssistantDb]

-- Change DB recovery model to Full and take full backup
ALTER DATABASE [AssistantDb] SET RECOVERY FULL ;
GO
BACKUP DATABASE [AssistantDb] TO  DISK = N'/var/opt/mssql/backup/AssistantDb.bak' WITH NOFORMAT, NOINIT,  NAME = N'AssistantDb-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
USE [master]
GO

--create logins for AG
CREATE LOGIN ag_login WITH PASSWORD = 'Welcome@0001234567';
CREATE USER ag_user FOR LOGIN ag_login;

-- Create a master key and certificate
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Welcome@0001234567';
GO
CREATE CERTIFICATE ag_certificate WITH SUBJECT = 'ag_certificate';

-- Copy these two files to the same directory on secondary replicas
BACKUP CERTIFICATE ag_certificate
TO FILE = '/var/opt/mssql/ag_certificate.cert'
WITH PRIVATE KEY (
        FILE = '/var/opt/mssql/ag_certificate.key',
        ENCRYPTION BY PASSWORD = 'Welcome@0001234567'
    );
GO

-- Create AG endpoint on port 5022
CREATE ENDPOINT [AG_endpoint]
STATE=STARTED
AS TCP (
    LISTENER_PORT = 5022,
    LISTENER_IP = ALL
)
FOR DATA_MIRRORING (
    ROLE = ALL,
    AUTHENTICATION = CERTIFICATE ag_certificate,
    ENCRYPTION = REQUIRED ALGORITHM AES
)

--Create AG primary replica
CREATE AVAILABILITY GROUP [K8sAG]
WITH (
    CLUSTER_TYPE = NONE
)
FOR REPLICA ON
N'mssql-primary-statefulset-0' WITH
(
    ENDPOINT_URL = N'tcp://mssql-primary-service.mssql:5022',
    AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
    SEEDING_MODE = AUTOMATIC,
    FAILOVER_MODE = MANUAL,
    SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
),
N'mssql-secondary-statefulset-0' WITH
(
    ENDPOINT_URL = N'tcp://mssql-secondary-service.mssql:5021',
    AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
    SEEDING_MODE = AUTOMATIC,
    FAILOVER_MODE = MANUAL,
    SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
);

-- Add database to AG
USE [master]
GO
ALTER AVAILABILITY GROUP [K8sAG] ADD DATABASE [AssistantDb]
GO
