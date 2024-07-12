## secondaries are readonly
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

