-- Sp Total Spent

CREATE OR ALTER PROC spTotalSpent
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

	select SUM(total_spent) as total_spent
	from fact_camp fc
	INNER JOIN dim_product dp 
	ON dp.platform_id = fc.platform_id
	INNER JOIN dim_location dl
	ON dl.location_id = fc.location_id
	WHERE YEAR(date) = @years
		AND dp.platform IN (' + @platformsFilter + ')
		AND dl.location IN (' + @locationsFilter + ')
	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spTotalSpent @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';


-- SP Average Cost Per Click

CREATE OR ALTER PROC spAvgCostPerClick
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '


	SELECT ROUND(AVG(cost_per_click),2) as avg_cpc
	from fact_camp fc
	INNER JOIN dim_product dp 
	ON dp.platform_id = fc.platform_id
	INNER JOIN dim_location dl
	ON dl.location_id = fc.location_id
	WHERE YEAR(date) = @years
		AND dp.platform IN (' + @platformsFilter + ')
		AND dl.location IN (' + @locationsFilter + ')
	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spAvgCostPerClick @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';



---------------------------------------------------
-- SP Average Conversion Rate 
CREATE OR ALTER PROC spAvgConversionRate
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

	SELECT ROUND(AVG(conversion_rate),0) as conversion_rate
	FROM fact_camp fc
	INNER JOIN dim_product dp 
	ON dp.platform_id = fc.platform_id
	INNER JOIN dim_location dl
	ON dl.location_id = fc.location_id
	WHERE YEAR(date) = @years
		AND dp.platform IN (' + @platformsFilter + ')
		AND dl.location IN (' + @locationsFilter + ')
	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spAvgConversionRate @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';



-- SP Total Impressions 
CREATE OR ALTER PROC spTotalImpression
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

	SELECT SUM(impressions) as total_impression
	FROM fact_camp fc
	INNER JOIN dim_product dp 
	ON dp.platform_id = fc.platform_id
	INNER JOIN dim_location dl
	ON dl.location_id = fc.location_id
	WHERE YEAR(date) = @years
		AND dp.platform IN (' + @platformsFilter + ')
		AND dl.location IN (' + @locationsFilter + ')
	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spTotalImpression @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';





------------------------------------------------------------------------------
-- FILTER IS DISABLED FOR THIS ALSO TESTING
-- SP Total Impressions vs spent
CREATE OR ALTER PROC spImpressionVsSpent
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

		SELECT
			dp.platform,
			SUM(impressions) as total_impression,
			SUM(total_spent) as total_spent 
		FROM fact_camp f
		INNER JOIN dim_product dp
		ON f.platform_id = dp.platform_id
		INNER JOIN dim_location dl
		ON f.location_id = dl.location_id
		WHERE YEAR(date) = @years
			AND dp.platform IN (' + @platformsFilter + ')
			AND dl.location IN (' + @locationsFilter + ')
		GROUP BY dp.platform
	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spImpressionVsSpent @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';



------------------------------------------------------------------------------
-- SP Average Cost Per Click Over Time
CREATE OR ALTER PROC spAvgCostPerClickByMonth
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

		SELECT 
			MONTH(date) as month,
			AVG(cost_per_click) as avg_cpc 
		FROM fact_camp f
		INNER JOIN dim_product dp
		ON f.platform_id = dp.platform_id
		INNER JOIN dim_location dl
		ON f.location_id = dl.location_id
		WHERE YEAR(date) = @years
			AND dp.platform IN (' + @platformsFilter + ')
			AND dl.location IN (' + @locationsFilter + ')
		GROUP BY MONTH(date) 

	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spAvgCostPerClickByMonth @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';




-------------------------------------------------------------------
-- KPI Total Spent
CREATE OR ALTER PROC spKPITotalSpent
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

		WITH cy_total_spent_cte
		AS
		(
			SELECT
				SUM(f.total_spent) as cy_total_spent 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		), 
		py_total_spent_cte
		AS
		(
			SELECT 
				SUM(total_spent) as py_total_spent 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years - 1
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		)

		SELECT 
			((cy_total_spent - py_total_spent) / py_total_spent)*100 as yoy_spent 
		FROM cy_total_spent_cte,py_total_spent_cte

	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spKPITotalSpent @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';


------------------------------------------------------------------------
-- KPI Average Cost Per Click
CREATE OR ALTER PROC spKPIAvgCostPerClick
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '


		WITH cy_cpc_cte
		AS
		(
			SELECT
				avg(cost_per_click) as cy_cpc 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		), 
		py_cpc_cte
		AS
		(
			SELECT 
				avg(cost_per_click) as py_cpc 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years - 1
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		)

		SELECT 
			((cy_cpc - py_cpc) / py_cpc)*100 as yoy_spent 
		FROM cy_cpc_cte,py_cpc_cte

	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spKPIAvgCostPerClick @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';




------------------------------------------------------------------------
-- KPI Average Conversion Rate
CREATE OR ALTER PROC spKPIConversionRate
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

	-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END


	-- base query 
	SET @sql = '

		WITH cy_avg_conv_rate_cte
		AS
		(
			SELECT
				avg(conversion_rate) as cy_conv_rate 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		), 
		py_avg_conv_rate_cte
		AS
		(
			SELECT 
				avg(conversion_rate) as py_conv_rate 
			FROM fact_camp f
			INNER JOIN dim_product dp
			ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl
			ON f.location_id = dl.location_id
			WHERE YEAR(date) = @years - 1
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		)

		SELECT 
			((cy_conv_rate - py_conv_rate) / py_conv_rate)*100 as yoy_spent 
		FROM cy_avg_conv_rate_cte,py_avg_conv_rate_cte

	'

	EXEC sp_executesql @sql, N'@years INT', @years = @year;

END

exec spKPIConversionRate @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';



------------------------------------------------------------------------
-- KPI Total Impression YoY
CREATE OR ALTER PROCEDURE spKPITotalImpression
	@year int = 2024,
	@platforms nvarchar(max) = NULL,
	@locations nvarchar(max) = NULL 
AS
BEGIN

	DECLARE @sql nvarchar(max);
	DECLARE @platformsFilter nvarchar(max);
	DECLARE @locationsFilter nvarchar(max);

		-- handle platform is null or not provided
	IF @platforms IS NULL OR @platforms = ' '
	BEGIN
		-- get all platforms if @platforms is null or empty 
		SELECT @platformsFilter = STRING_AGG(QUOTENAME(platform, ''''), ',')
		FROM dim_product
	END
	ELSE 
	BEGIN
		SET @platformsFilter = @platforms;
	END


	-- handle locations
	IF @locations IS NULL OR @locations = ' '
	BEGIN 
		-- get all locations if @locations is null or empty 
		SELECT @locationsFilter = STRING_AGG(QUOTENAME(location, ''''), ',') 
		FROM dim_location 
	END 
	ELSE
	BEGIN
		SET @locationsFilter = @locations
	END

	-- base query 
	SET @sql = '
		WITH cy_total_impression_cte AS (
			SELECT
				SUM(CAST(impressions AS DECIMAL(10,2))) AS cy_impression 
			FROM fact_camp f
			INNER JOIN dim_product dp ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl ON f.location_id = dl.location_id
			WHERE YEAR(date) = @year
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		), 
		py_total_impression_cte AS (
			SELECT 
				SUM(CAST(impressions AS DECIMAL(10,2))) AS py_impression 
			FROM fact_camp f
			INNER JOIN dim_product dp ON f.platform_id = dp.platform_id
			INNER JOIN dim_location dl ON f.location_id = dl.location_id
			WHERE YEAR(date) = @year - 1
				AND dp.platform IN (' + @platformsFilter + ')
				AND dl.location IN (' + @locationsFilter + ')
		)
		SELECT 
			((CAST(cy_impression AS DECIMAL(10,2)) - py_impression) / NULLIF(py_impression, 0))*100 AS yoy_spent 
		FROM cy_total_impression_cte
		CROSS JOIN py_total_impression_cte
	'

	EXEC sp_executesql @sql, N'@year INT', @year = @year;

END


exec spKPITotalImpression @year = 2024, 
			@platforms = '''facebook'',''instagram''',
			@locations = '''bhaktapur'',''kathmandu''';
