SELECT *
FROM 
    INFORMATION_SCHEMA.PARAMETERS
WHERE 
    SPECIFIC_NAME = 'sp_SPW_CreateMemberResult';

    
EXEC sp_helptext 'sp_SPW_CreateMemberResult';



SELECT DISTINCT 
    o.name AS ObjectName
FROM sys.sql_modules m
INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%Spw_DrawResult%'
ORDER BY  o.name;
EXEC sp_helptext 'sp_SPW_CreateMemberResult';
-- select * from Spw_DrawResult order by CreatedDate DESC

-- select * from Spw_PrizeList ORDER by CreatedDate desc

-- select * from Spw_DrawResult ORDER BY CreatedDate DESC

-- select * from Spw_PrizeList where id = 66617 order by CreatedDate desc
SELECT *
FROM 
    INFORMATION_SCHEMA.PARAMETERS
WHERE 
    SPECIFIC_NAME = 'sp_SPW_CreateMemberResult';

    
EXEC sp_helptext 'sp_SPW_CreateMemberResult';



SELECT DISTINCT 
    o.name AS ObjectName
FROM sys.sql_modules m
INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%Spw_DrawResult%'
ORDER BY  o.name;

-- select * from Spw_DrawResult order by CreatedDate DESC

-- select * from Spw_PrizeList ORDER by CreatedDate desc

-- select * from Spw_DrawResult ORDER BY CreatedDate DESC

-- select * from Spw_PrizeList where id = 66617 order by CreatedDate desc