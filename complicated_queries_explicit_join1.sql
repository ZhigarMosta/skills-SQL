IF DB_ID(N'db5_task1') IS NULL BEGIN
	CREATE DATABASE [db5_task1]
END ELSE BEGIN
	PRINT N'База данных db5_task1 уже существует'
END

USE db5_task1

IF OBJECT_ID(N'provider') IS NULL BEGIN
	CREATE TABLE [provider](
		[id] INT NOT NULL,
		[p_name] NVARCHAR(50) NOT NULL,
		[p_rating] INT NOT NULL,
		[s_city] NVARCHAR(50) NOT NULL,

		CONSTRAINT [PK_id_provider] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица provider уже существует'
END

IF OBJECT_ID(N'product') IS NULL BEGIN
	CREATE TABLE product(
		[id] INT NOT NULL,
		[p_name] NVARCHAR(50) NOT NULL,
		[p_prise] MONEY NOT NULL 


		CONSTRAINT [PK_id_product] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица product уже существует'
END

IF OBJECT_ID(N'supply') IS NULL BEGIN
	CREATE TABLE supply(
		[id] INT NOT NULL,
		[id_provider] INT NOT NULL,
		[id_product] INT NOT NULL,
		[count_products] INT NOT NULL

		CONSTRAINT [PK_id_supply] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица provider уже существует'
END

ALTER TABLE [supply]
ADD CONSTRAINT [supply_FK_provider_id] FOREIGN KEY ([id_provider])
REFERENCES [provider] ([id])
ON UPDATE CASCADE,

CONSTRAINT [supply_FK_product_id] FOREIGN KEY ([id_product])
REFERENCES [product] ([id])
ON UPDATE CASCADE

DROP TABLE [supply],[product], [provider]

INSERT INTO
	[provider]
VALUES
	(1,N'Андрей',50,N'Москва'),
	(2,N'Илья',5,N'Челябинск'),
	(3,N'Михаил',10,N'Москва'),
	(4,N'Антон',11,N'Челябинск'),
	(5,N'Данил',32,N'Питер'),
	(6,N'Алексей',50,N'Омск'),
	(7,N'Дима',1,N'Омск'),
	(8,N'Владимер',1,N'Челябинск'),
	(9,N'Кирилл',5,N'Челябинск')

INSERT INTO
	[product]
VALUES
	(1,N'колесо',15000),
	(2,N'шина',5000),
	(3,N'стекло',4000),
	(4,N'молоток',100),
	(5,N'топор',150)

INSERT INTO
	[supply]
VALUES
	(1,2,1,20),
	(2,1,2,15),
	(3,3,3,1),
	(4,4,5,12),
	(5,5,4,10)

-- лаба 7/задание 15.02.2024
--не явный join
SELECT[p1].[p_name] as [имя первого],
[p1].[s_city] as [город первого],
[p1].[p_rating] as [рейтинг первого],
NULL as [имя второго],
NULL as [город второго],
NULL as [рейтинг второго]
FROM [provider] as [p1], [provider] as [p2]
WHERE [p2].[id] = [p1].[id] and [p1].[s_city] in (
SELECT [p1].[s_city]
FROM [provider] as [p1]
GROUP BY [p1].[s_city]
HAVING COUNT(*)=1
)
GROUP BY [p1].[s_city],[p1].[p_name],[p1].[p_rating]

UNION

SELECT[p1].[p_name],
[p1].[s_city],
[p1].[p_rating],
[p2].[p_name],
[p2].[s_city],
[p2].[p_rating]
FROM [provider] as [p1], [provider] as [p2]
WHERE  [p2].[id] != [p1].[id]
and [p1].[s_city] = [p2].[s_city]
and [p2].[p_rating] >= [p1].[p_rating]
GROUP BY [p1].[s_city],[p1].[p_name],[p1].[p_rating],[p2].[s_city],[p2].[p_name],[p2].[p_rating]
ORDER BY [p1].[s_city] ASC

-- лаба 7/задание 15.02.2024
--явный join
SELECT [p1].[p_name] as [имя первого],
[p1].[s_city] as [город первого],
[p1].[p_rating] as [рейтинг первого],
NULL as [имя второго], NULL as [город второго],
NULL as [рейтинг второго] FROM [provider] as [p1]
INNER JOIN [provider] as [p2] on [p2].[id] = [p1].[id]
WHERE [p1].[s_city] in (
	SELECT [p1].[s_city]
	FROM [provider] as [p1]
	GROUP BY [p1].[s_city]
	HAVING COUNT(*) = 1 
)
	GROUP BY [p1].[s_city], [p1].[p_name], [p1].[p_rating]

UNION

SELECT [p1].[p_name],
[p1].[s_city],
[p1].[p_rating],
[p2].[p_name],
[p2].[s_city],
[p2].[p_rating]
FROM [provider] as [p1]
INNER JOIN [provider] as [p2] on [p2].[s_city] = [p1].[s_city]
and [p2].[p_rating] >= [p1].[p_rating]
and [p2].[id] != [p1].[id]
GROUP BY [p1].[s_city],[p1].[p_name], [p1].[p_rating], [p2].[s_city], [p2].[p_name], [p2].[p_rating]
ORDER BY [p1].[s_city] ASC
