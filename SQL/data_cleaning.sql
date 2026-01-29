-- Data Cleaning
-- Xử lí duplicate trong trong sql server
-- 1. Tìm dòng trùng nhau --
Select App, COUNT(*) 
from googleplaystore
Group by App
Having COUNT(*)>1;
-- 2. Lấy toàn bộ dòng của các cột trùng (Ở đây dùng hàm subquery)
Select *
From googleplaystore
Where App In (
	Select App 
	from googleplaystore
	Group by App
	Having COUNT(*)>1
	);
-- 3. Xóa các hàm duplicate
With CTE AS (
		Select *,
				ROW_NUMBER() Over (Partition by App Order by Last_Updated Desc) as rn
		From googleplaystore
		)
Delete from CTE
where rn > 1;
-- Đối với missing value nên để nguyên là Null
-- Chuẩn hóa dữ liệu
Select distinct Installs from googleplaystore;

UPDATE googleplaystore
SET Installs =
    CASE
        WHEN Installs LIKE 'Free' THEN 0
        ELSE CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS INT)
    END;

UPDATE googleplaystore
SET Size =
    CASE
        WHEN Size LIKE '%M' THEN 
            CAST(REPLACE(Size, 'M', '') AS FLOAT)
        WHEN Size LIKE '%k' THEN 
            CAST(REPLACE(Size, 'k', '') AS FLOAT) / 1024.0
        ELSE NULL
    END;
--Loại bỏ oulier
Delete From googleplaystore
Where Rating <0 or Rating > 5;
