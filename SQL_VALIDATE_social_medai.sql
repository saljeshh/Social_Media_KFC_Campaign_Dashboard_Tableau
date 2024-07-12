select * from fact_camp 

-- total spent
create proc total_spent_by_year
	@year int = 2024
AS
BEGIN
select SUM(total_spent) as total_spent
from fact_camp 
where YEAR(date) = @year
END

exec total_spent_by_year @year = 2023


-- average cost per click 
create or alter proc avg_cost_per_click 
	@year int = 2024
AS
BEGIN

SELECT ROUND(AVG(cost_per_click),2) as avg_cpc
FROM fact_camp 
where YEAR(date) = @year 

END

exec avg_cost_per_click @year = 2023


-- average conversion rate
CREATE OR ALTER PROC avg_conversion_rate
	@year int = 2024
AS
BEGIN

	SELECT ROUND(AVG(conversion_rate),0) as conversion_rate
	FROM fact_camp 
	WHERE YEAR(date) = @year
	
END

EXEC avg_conversion_rate @year = 2023


-- total impression
CREATE PROC total_impression
	@year int = 2024 
AS
BEGIN

	SELECT SUM(impressions) as total_impression
	FROM fact_camp 
	WHERE YEAR(date) = @year 

END 

EXEC total_impression @year = 2023



-- total impression vs spent by platform
CREATE OR ALTER PROC spImp_vs_platform
	@year int = 2024
AS
BEGIN

	SELECT
		p.platform,
		SUM(impressions) as total_impression,
		SUM(total_spent) as total_spent 
	FROM fact_camp f
	INNER JOIN dim_product p
	ON f.platform_id = p.platform_id
	WHERE YEAR(date) = @year
	GROUP BY p.platform

END 

EXEC spImp_vs_platform @year = 2023



-- average cost per click 

CREATE OR ALTER PROC spAvgCostPerClick
	@year int = 2024 
AS
BEGIN
	
	SELECT 
		MONTH(date) as month,
		AVG(cost_per_click) as avg_cpc 
	FROM fact_camp 
	WHERE YEAR(date) = @year 
	GROUP BY MONTH(date) 

END 


EXEC spAvgCostPerClick @year = 2023


-- kpi yoy total spent 

CREATE OR ALTER PROC spTotalSpentKPIYoY
	@year int = 2024
AS
BEGIN

	WITH cy_total_spent_cte
	AS
	(
		SELECT
			SUM(total_spent) as cy_total_spent 
		FROM fact_camp
		WHERE YEAR(date) = @year
	), 
	py_total_spent_cte
	AS
	(
		SELECT 
			SUM(total_spent) as py_total_spent 
		FROM fact_camp 
		WHERE year(date) = @year - 1
	)

	SELECT 
		((cy_total_spent - py_total_spent) / py_total_spent)*100 as yoy_spent 
	FROM cy_total_spent_cte,py_total_spent_cte

END


exec spTotalSpentKPIYoY @year = 2024



-- kpi avg cost per click

CREATE OR ALTER PROC spAvgCPC
	@year int = 2024
AS
BEGIN

	WITH cy_cpc_cte
	AS
	(
		SELECT
			avg(cost_per_click) as cy_cpc 
		FROM fact_camp
		WHERE YEAR(date) = @year
	), 
	py_cpc_cte
	AS
	(
		SELECT 
			avg(cost_per_click) as py_cpc 
		FROM fact_camp 
		WHERE year(date) = @year - 1
	)

	SELECT 
		((cy_cpc - py_cpc) / py_cpc)*100 as yoy_spent 
	FROM cy_cpc_cte,py_cpc_cte

END


exec spAvgCPC @year = 2024




-- kpi avg conversion rate

CREATE OR ALTER PROC spAvgConvRate
	@year int = 2024
AS
BEGIN

	WITH cy_avg_conv_rate_cte
	AS
	(
		SELECT
			avg(conversion_rate) as cy_conv_rate 
		FROM fact_camp
		WHERE YEAR(date) = @year
	), 
	py_avg_conv_rate_cte
	AS
	(
		SELECT 
			avg(conversion_rate) as py_conv_rate 
		FROM fact_camp 
		WHERE year(date) = @year - 1
	)

	SELECT 
		((cy_conv_rate - py_conv_rate) / py_conv_rate)*100 as yoy_spent 
	FROM cy_avg_conv_rate_cte,py_avg_conv_rate_cte

END


exec spAvgConvRate @year = 2024



-- kpi total impression

CREATE OR ALTER PROC spTotalImpression
	@year int = 2024
AS
BEGIN

	WITH cy_total_impression_cte
	AS
	(
		SELECT
			sum(impressions) as cy_impression 
		FROM fact_camp
		WHERE YEAR(date) = @year
	), 
	py_total_impression_cte
	AS
	(
		SELECT 
			sum(impressions) as py_impression 
		FROM fact_camp 
		WHERE year(date) = @year - 1
	)

	SELECT 
		((CAST(cy_impression AS DECIMAL(10,2)) - py_impression) / py_impression)*100 as yoy_spent 
	FROM cy_total_impression_cte,py_total_impression_cte

END


exec spTotalImpression @year = 2024