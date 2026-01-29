-- Câu hỏi nghiệp vụ
-- 1. Category nào có rating trung bình cao nhất?
Select top 1
	Category,
	AVG(Rating)
From googleplaystore
Where Category is not Null
Group by category;
		
-- 2. App miễn phí hay trả phí có rating cao hơn?
Select
	App,
	Price,
	Rating
From googleplaystore
Where Rating is not Null
Order by Rating Desc;
-- 3. App lớn (size lớn) có rating tốt hơn không?
-- Tạo CTE (Common table expression) để chuyển Size(string) sang float
With Change_size_float as (
			Select
				Rating,
				Case 
					When Size Like '%M' then cast(REPLACE(Size,'M', '') As Float)
					Else Null
				End as Size_MB
			From googleplaystore
)
-- select để trả lời
Select
	Case
		When Size_MB < 10 then 'Small'
		WHEN Size_MB BETWEEN 10 AND 50 THEN 'Medium'
        WHEN Size_MB BETWEEN 50 AND 200 THEN 'Large'
        WHEN Size_MB > 200 THEN 'Huge'
        ELSE 'Unknown'
	End as Size_group,
	AVG(Rating) as Average_Rate,
	Count(*) as AppCount
From Change_size_float
Group by 
	Case
		When Size_MB < 10 then 'Small'
		WHEN Size_MB BETWEEN 10 AND 50 THEN 'Medium'
        WHEN Size_MB BETWEEN 50 AND 200 THEN 'Large'
        WHEN Size_MB > 200 THEN 'Huge'
        ELSE 'Unknown'
	End
Order by Average_Rate Desc;
-- > App lớn rating không tố hơn nhiều so với app nhỏ
								
-- 5. Mối quan hệ giữa số review và số installs?
Select
	Case
		WHEN Installs < 10000 THEN '0-10K'
        WHEN Installs < 100000 THEN '10K-100K'
        WHEN Installs < 1000000 THEN '100K-1M'
        WHEN Installs < 10000000 THEN '1M-10M'
        ELSE '10M+'
	End as Install_Group,
	COUNT(*) AS Total_Apps,
    AVG(Reviews) AS Avg_Reviews_per_app
From googleplaystore
Group by
	Case
		WHEN Installs < 10000 THEN '0-10K'
        WHEN Installs < 100000 THEN '10K-100K'
        WHEN Installs < 1000000 THEN '100K-1M'
        WHEN Installs < 10000000 THEN '1M-10M'
        ELSE '10M+'
	End
Order by MIN(Installs);
-- 6. Những app nào bị đánh giá quá thấp (<3)? Họ thuộc category nào?
Select
	App,
	Rating,
	Category
From googleplaystore
Where Rating < 3
-- 7. Category nào có tỷ lệ app trả phí cao?
Select
	Category,
	Cast(
		Sum(Case When Price > 0 Then 1 Else 0 End) * 100.0/Count(*)
		AS DECIMAL(5,2)
		) as percent_rate
From googleplaystore
Group by Category
Order by percent_rate Desc;

-- 8. Đâu là “khoảng trống thị trường”: category rating cao nhưng ít app?
Select
	Category,
	AVG(Rating) as AVG_Rating,
	Count(*) as TotalApp
From googleplaystore
Group By Category
HAVING AVG(Rating) IS NOT NULL
Order by AVG_Rating DESC, TotalApp ASC;
