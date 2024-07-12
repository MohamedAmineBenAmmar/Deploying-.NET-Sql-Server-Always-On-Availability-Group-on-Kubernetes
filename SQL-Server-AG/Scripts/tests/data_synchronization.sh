#Insert 10000 records into the table
INSERT INTO AG_Test
(
 ID,
 RandomData
)
VALUES
(
 NEWID(),
 CONVERT(VARCHAR(50), NEWID())
);
GO 10000

#in Secondary one records are synced
Select count(*) from AG_Test
(No column name)
10000

#in Secondary two records are synced
Select count(*) from AG_Test
(No column name)
10000