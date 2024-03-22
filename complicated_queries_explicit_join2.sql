IF DB_ID(N'db5') IS NULL BEGIN
	CREATE DATABASE [db5]
END ELSE BEGIN
	PRINT N'База данных db5 уже существует'
END

USE db5

IF OBJECT_ID(N'dish') IS NULL BEGIN
	CREATE TABLE [dish](
		[id] INT NOT NULL,
		[name] NVARCHAR(50) NOT NULL,
		[category] NVARCHAR(50) NOT NULL

		CONSTRAINT [PK_id_dish] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица dish уже существует'
END

IF OBJECT_ID(N'product') IS NULL BEGIN
	CREATE TABLE product(
		[id] INT NOT NULL,
		[name] NVARCHAR(50) NOT NULL,
		[calorie] INT NOT NULL 

		CONSTRAINT [PK_id_product] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица product уже существует'
END

IF OBJECT_ID(N'recipe') IS NULL BEGIN
	CREATE TABLE recipe(
		[id] INT NOT NULL,
		[id_dish] INT NULL,
		[id_product] INT NULL,
		[count_products] INT NULL

		CONSTRAINT [PK_id_supplyf] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица provider уже существует'
END

ALTER TABLE [recipe]
ADD CONSTRAINT [supply_FK_dfish_id] FOREIGN KEY ([id_dish])
REFERENCES [dish] ([id])
ON UPDATE CASCADE,

CONSTRAINT [supply_FK_producft_id] FOREIGN KEY ([id_product])
REFERENCES [product] ([id])
ON UPDATE CASCADE


INSERT INTO
	[dish]
VALUES
	(1,N'пицца',N'вкуснок'),
	(2,N'мороженое',N'вкуснок'),
	(3,N'вода',N'не вкусное'),
	(4,N'воздух',N'без коментариев...'),
	(5,N'макароны',N'вкусное'),
	(6,N'оливье',N'вкусное')

INSERT INTO
	[product]
VALUES
	(1,N'ничего',0),
	(2,N'колбаса',5),
	(3,N'сыр',5),
	(4,N'чеснок',10),
	(5,N'соль',10)

INSERT INTO
	[recipe]
VALUES
	(1,2,1,1),
	(2,1,2,1),
	(3,3,3,55),
	(4,4,5,12),
	(5,5,4,10),
	(6,1,2,51)

-- лаба 7/задание 15.02.2024
--не явный join
SELECT	[d].[id] as [индификатор],
		[d].[name] as [название]
FROM	[dish] as [d]
WHERE	[d].[id] not in (
	SELECT DISTINCT [rc].[id_dish]
	FROM [recipe] as [rc]
)

UNION

SELECT [d].[id] as [id], [d].[name] as [Название]
FROM [dish] as [d], [recipe] as [r], [product] as [p]
WHERE [d].[name] in (
    SELECT [d].[name]
    FROM [dish] as [d], [recipe] as [r]
    WHERE [d].[id] = [r].[id_dish]
    GROUP BY [d].[name]
	HAVING COUNT (*) >= 0
) and [d].[id] = [r].[id_dish] and [r].[id] = [p].[id] and [p].[calorie] * [r].[count_products] < 50

-- лаба 7/задание 15.02.2024
--явный join
SELECT [d].[id] as [индификатор],
[d].[name] as [название]
FROM [dish] as [d]
WHERE [d].[id] not in (
	SELECT DISTINCT [rc].[id_dish]
	FROM [recipe] as [rc]
)

UNION

SELECT [d].[id] as [индификатор], [d].[name] as [название] FROM [dish] as [d]
INNER JOIN [recipe] as [r] on [d].[id] = [r].[id_dish]
INNER JOIN [product] as [p] on [r].[id] = [p].[id]
WHERE [d].[name] in( 
	SELECT [d].[name] FROM [dish] as [d]
	INNER JOIN [recipe] as [r] on [d].[id] = [r].[id_dish]
	GROUP BY [d].[name]
	HAVING COUNT(*) >= 0 
) and [p].[calorie] * [r].[count_products] < 50