--Number of Majors by category and number of degrees
Select 
	COUNT(Distinct Major_Category) as [Number of Majors],
	COUNT(Distinct Major) as [Number of Degrees]
From
	Colleges.dbo.Majors;

--Pay scale  by Major Category
Select Major_Category,
	MAX(Median) as [Max_pay],
	AVG(Median) as [avg_pay],
	MIN(Median) as [min_pay]
From 
	Colleges.dbo.RecentGrads
Group By 
	Major_category
Order By
	[avg_pay] DESC;

--Look for majors who pay over 50K
Select 
	Major,
	Major_category,
	Total as [Graduates],
	Employed,
	Unemployed,
	Median as [Average Pay],
	Case 
		when Unemployment_rate <= .055 Then 'YES'
		when Unemployment_rate > .055 Then 'NO'
		END as [Below 5 Percent Unemployment],
	ROUND(Unemployment_rate, 5) as [Unemployment Rate]
From
	Colleges.dbo.RecentGrads
Where 
	Median > 50000 
Order by 
	[Unemployment Rate] ASC, [Average Pay] DESC;

--A lot are engineering so removed from the list
Select 
	Major,
	Major_category,
	Median as [Average Pay],
	Case 
		when Unemployment_rate <= .05 Then 'YES'
		when Unemployment_rate > .05 Then 'NO'
		END as [Below 5 Percent Unemployment],
		ROUND(Unemployment_rate, 5) as [Unemployment Rate]
From
	Colleges.dbo.RecentGrads
Where 
	Median > 50000 AND 
	Major_category not like 'Engineering'

Order by 
	[Average Pay] DESC;

