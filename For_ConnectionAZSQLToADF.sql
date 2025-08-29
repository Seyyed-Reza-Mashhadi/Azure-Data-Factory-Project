-- Run in master
CREATE LOGIN [adfgrocery] FROM EXTERNAL PROVIDER;


-- Run in az-sqldatabase-grocery
CREATE USER [adfgrocery] FROM EXTERNAL PROVIDER;

ALTER ROLE db_datareader ADD MEMBER [adfgrocery];
ALTER ROLE db_datawriter ADD MEMBER [adfgrocery];

-- Optional (only if you want ADF to have full control)
-- ALTER ROLE db_owner ADD MEMBER [adfgrocery];
