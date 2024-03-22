IF DB_ID(N'db__9') IS NULL BEGIN
	CREATE DATABASE [db__9]-- [db__12]
END ELSE BEGIN
	PRINT N'База данных db__9 уже существует'
END

--USE db__12

USE db__9

IF OBJECT_ID(N'city') IS NULL BEGIN
	CREATE TABLE [city](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[ratio] FLOAT NOT NULL,
		[cost_living] MONEY NOT NULL,

		CONSTRAINT [PK_city_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица provider уже существует'
END

IF OBJECT_ID(N'provider') IS NULL BEGIN
	CREATE TABLE [provider](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[type] NVARCHAR(50) NOT NULL,
		[city_id] INT NOT NULL,

		CONSTRAINT [PK_provider_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица provider уже существует'
END

IF OBJECT_ID(N'shop') IS NULL BEGIN
	CREATE TABLE [shop](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[city_id] INT NOT NULL,

		CONSTRAINT [PK_shop_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица shop уже существует'
END

IF OBJECT_ID(N'product') IS NULL BEGIN
	CREATE TABLE [product](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[provider_id] INT NOT NULL,

		CONSTRAINT [PK_product_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица product уже существует'
END

IF OBJECT_ID(N'employee') IS NULL BEGIN
	CREATE TABLE [employee](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[salary] MONEY DEFAULT 10000,
		[shop_id] INT NOT NULL,

		CONSTRAINT [PK_employee_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица employee уже существует'
END

IF OBJECT_ID(N'breakdown') IS NULL BEGIN
	CREATE TABLE [breakdown](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,

		CONSTRAINT [PK_breakdown_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица breakdown уже существует'
END

IF OBJECT_ID(N'equipment') IS NULL BEGIN
	CREATE TABLE [equipment](
		[id] INT NOT NULL IDENTITY,
		[name] NVARCHAR(100) NOT NULL,
		[last_maintenance_date] DATE,
		[next_maintenance_date] DATE,
		[breakdown_date] DATE,
		[repair_start_date] DATE,
		[repair_end_date_date] DATE,
		[breakdown] INT

		CONSTRAINT [PK_equipment_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица equipment уже существует'
END

IF OBJECT_ID(N'delivery') IS NULL BEGIN
	CREATE TABLE [delivery](
		[id] INT NOT NULL IDENTITY,
		[product_id] INT NOT NULL,
		[store_id] INT NOT NULL,
		[provider_id] INT NOT NULL,
		[count_product] INT,
		[total_cost] MONEY,

		CONSTRAINT [PK_delivery_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица delivery уже существует'
END

IF OBJECT_ID(N'sales') IS NULL BEGIN
	CREATE TABLE sales(
		[id] INT NOT NULL IDENTITY,
		[product_id] INT NOT NULL,
		[count_product] INT,
		[total_cost] MONEY,
		[date] DATE

		CONSTRAINT [PK_sales_id] PRIMARY KEY([id])
	)
END ELSE BEGIN
	PRINT N'Таблица sales уже существует'
END

ALTER TABLE [provider]
ADD CONSTRAINT [provider_FK_city_id] FOREIGN KEY ([city_id])
REFERENCES [city] ([id])
ON UPDATE CASCADE

ALTER TABLE [shop]
ADD CONSTRAINT [shop_FK_city_id] FOREIGN KEY ([city_id])
REFERENCES [city] ([id])
ON UPDATE CASCADE

ALTER TABLE [product]
ADD CONSTRAINT [product_FK_provider_id] FOREIGN KEY ([provider_id])
REFERENCES [provider] ([id])
ON UPDATE CASCADE

ALTER TABLE [delivery]
ADD CONSTRAINT [delivery_FK_product_id] FOREIGN KEY ([product_id])
REFERENCES [product] ([id])
ON UPDATE NO ACTION,

CONSTRAINT [delivery_FK_store_id] FOREIGN KEY ([store_id])
REFERENCES [shop] ([id])
ON UPDATE NO ACTION,

CONSTRAINT [delivery_FK_provider_id] FOREIGN KEY ([provider_id])
REFERENCES [provider] ([id])
ON UPDATE NO ACTION

ALTER TABLE [equipment] ADD  CONSTRAINT [delivery_FK_breakdown_id] FOREIGN KEY ([breakdown])
REFERENCES [breakdown] ([id])
ON UPDATE NO ACTION

ALTER TABLE sales ADD  CONSTRAINT [sales_FK_product_id] FOREIGN KEY ([product_id])
REFERENCES product ([id])
ON UPDATE NO ACTION

drop database db__9
USE db__12

INSERT INTO
	[city] --имя коэфицент
VALUES
	(N'Челябинск',0.1,14279),
	(N'Москва',0.2,18296),
	(N'Омкс',0.3,14958),
	(N'Екатеринбург',0.4,16460)

INSERT INTO
	[provider] --имя тип город
VALUES
	(N'Максим',N'Федеральный',1),
	(N'Никита',N'Областной',1),
	(N'Анна',N'Федеральный',2),
	(N'Кирилл',N'ещё какой то тип',2),
	(N'Анатолий',N'Федеральный',3),
	(N'Александр',N'ещё какой то тип',3),
	(N'Евгений',N'Федеральный',4),
	(N'Андрей',N'Областной',4)

INSERT INTO
	[shop] --имя город
VALUES
	(N'Магазин 1',1),
	(N'Магазин 2',2),
	(N'Магазин 3',3),
	(N'Магазин 4',4)

INSERT INTO
	[product] --имя поставщик
VALUES
	(N'Продукт 1',1),
	(N'Продукт 2',2),
	(N'Продукт 3',3),
	(N'Продукт 4',4)

INSERT INTO
	[employee] ([name],[shop_id])
VALUES
	(N'Сотрудник 1',1),
	(N'Сотрудник 2',2),
	(N'Сотрудник 3',3),
	(N'Сотрудник 4',4)

INSERT INTO
	[breakdown] ([name])
VALUES
	(N'Поломка 1'),
	(N'Поломка 2'),
	(N'Поломка 3'),
	(N'Поломка 4')

INSERT INTO
	[equipment] --имя. дата последнего обслуживания. дата следующего обслуживания. дата поломки. дата начала ремонта. дата окончания ремонта. название последней поломки
VALUES
	(N'Оборудование 1', '2024-05-20', '2025-05-20', NULL, NULL, NULL, NULL),
	(N'Оборудование 2', '2023-07-10', '2028-07-10', '2022-03-15', '2022-03-15', '2022-03-20',1),
	(N'Оборудование 3', '2021-09-30', '2027-09-30', '2022-03-25', '2022-03-25','2022-03-25',2),
	(N'Оборудование 4', '2021-09-30', '2024-03-26', '2022-03-25', '2022-03-25','2022-03-25',2)
	------------------------------------поменять 10

INSERT INTO -- поставка
	[delivery] -- продукт магазин поставщик число деньги
VALUES
	(1, 2, 3, 10 , 1000)

INSERT INTO -- поставка
	sales -- продукт количество цена дата
VALUES
	(1, 20, 11111, '2024-03-25'),
	(2, 21, 21111, '2024-03-25'),
	(3, 22, 31111, '2024-03-25'),
	(1, 20, 11111, '2024-04-25')


--1
go
CREATE PROCEDURE [get_providers](
    @city_name NVARCHAR(50)
) AS BEGIN
    DECLARE @id_city INT = -1

    SELECT @id_city = [c].[id]
    FROM [city] as [c]
    WHERE [c].[name] = @city_name

    IF @id_city= -1 BEGIN
        PRINT CONCAT (N'Город ', @city_name, N' не существует')
        RETURN
    END

    SELECT *
    FROM [provider] as [p]
    WHERE [p].[city_id] = @id_city
END
GO

DECLARE @city NVARCHAR(50) = N'Челябинск'
EXEC [get_providers] @city
GO

--2
CREATE PROCEDURE [create_shop](
 @shop_name NVARCHAR(50), @id_city INT 
) AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [c].[id]
    FROM [city] as [c]
    WHERE [c].[id] = @id_city

	IF @check = -1 BEGIN
        PRINT CONCAT(N'города ', @id_city, N' не суеществует')
        RETURN
    END
    INSERT INTO [shop] ([name], [city_id])
    VALUES (@shop_name, @id_city)

	SELECT *
	FROM [shop]
END
GO

DECLARE @shop NVARCHAR(50) = N'название', @id_city INT = 2
EXEC [create_shop] @shop, @id_city
GO

--3
CREATE PROCEDURE [delete_shop](
	@id_shop INT
) AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [s].[id]
    FROM [shop] as [s]
    WHERE [s].[id] = @id_shop

	IF @check = -1 BEGIN
        PRINT CONCAT(N'города ', @id_shop, N' не суеществует')
        RETURN
    END

    DELETE FROM [shop]
    WHERE [id] = @id_shop

	SELECT *
	FROM [shop]
	return

END

DECLARE @shop INT = 3
EXEC [delete_shop] @shop
GO

--4
CREATE PROCEDURE [task4](
	@type NVARCHAR(50)
) AS BEGIN
    SELECT [prod].[name]
	FROM [product] as [prod]
	INNER JOIN [provider] as [prov] ON [prov].[id] = [prod].[id]
	INNER JOIN [delivery] as [d] ON [prov].[id] = [d].[id]
	WHERE [prov].[type] = @type
END
GO

--Федеральный
--Областной
DECLARE @type NVARCHAR(50) = N'Федеральный'
EXEC [task4] @type
GO

--5
CREATE PROCEDURE [task5](
	@id_city INT,@name NVARCHAR(50)
) AS BEGIN
	DECLARE @check INT = -1
    SELECT @check = [с].[id]
    FROM [city] as [с]
    WHERE [с].[id] = @id_city

	IF @check = -1 BEGIN
        PRINT CONCAT(N'города ', @id_city, N' не суеществует')
        RETURN
    END

	INSERT INTO [provider] ([name], [type], [city_id])
	VALUES (@name, N'Федеральный',@id_city)

	SELECT *
	FROM [provider]
END
GO

DECLARE @id_city INT = 2, @name NVARCHAR(50) = N'имя'
EXEC [task5] @id_city, @name
GO

--6
CREATE PROCEDURE [task6](
	@id_city INT,@name NVARCHAR(50)
) AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [с].[id]
    FROM [city] as [с]
    WHERE [с].[id] = @id_city

	IF @check = -1 BEGIN
        PRINT CONCAT(N'города ', @id_city, N' не суеществует')
        RETURN
    END

	INSERT INTO [provider] ([name], [type], [city_id])
	VALUES (@name, N'Областной',@id_city)

	SELECT *
	FROM [provider]
END
GO

DECLARE @id_city INT = 1, @name NVARCHAR(50) = N'имя'
EXEC [task6] @id_city, @name
GO

--7
CREATE PROCEDURE [task7](
	@id_city1 INT,@name1 NVARCHAR(50),
	@id_city2 INT,@name2 NVARCHAR(50)
) AS BEGIN

	EXEC [task5] @id_city1, @name1

	EXEC [task6] @id_city2, @name2
END
GO

DECLARE @id_city1 INT = 1, @name1 NVARCHAR(50) = N'имя'
DECLARE @id_city2 INT = 1, @name2 NVARCHAR(50) = N'имя'
EXEC [task7] @id_city1, @name1, @id_city2, @name2
GO

--8
CREATE PROCEDURE [delete_provider](
	@id_provider INT
) AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [p].[id]
    FROM [provider] as [p]
    WHERE [p].[id] = @id_provider

	IF @check = -1 BEGIN
        PRINT CONCAT(N'поставщика ', @id_provider, N' не суеществует')
        RETURN
    END

    DELETE FROM [provider]
    WHERE [id] = @id_provider

	SELECT *
	FROM [provider]
	return

END

DECLARE @id_provider INT = 8
EXEC [delete_provider] @id_provider
GO

--9
CREATE PROCEDURE [create_employee](
	@name NVARCHAR(50), @id_shop INT
) AS BEGIN

	DECLARE @id_shop_check INT = -1
    SELECT @id_shop_check = [s].[id]
    FROM [shop] as [s]
    WHERE [s].[id] = @id_shop

	IF @id_shop_check = -1 BEGIN
        PRINT CONCAT(N'магазина ', @id_shop, N' не суеществует')
        RETURN
    END



    INSERT INTO [employee] ([name],[shop_id])
    VALUES (@name, @id_shop)

	SELECT *
	FROM [employee]

	DECLARE @ratio FLOAT, @salary FLOAT, @cost_living FLOAT
	SELECT @ratio = [c].[ratio], @salary = [e].[salary], @cost_living = [c].[cost_living]
	FROM [city] as [c]
	INNER JOIN [shop] as [s] on [s].[id] = [c].[id]
	INNER JOIN [employee] as [e] on [e].[id] = [s].[id]
	WHERE [c].[id] = @id_shop

	print (@salary * @ratio) + (@cost_living * 0.08)
END

DECLARE @name NVARCHAR(50) = N'имя', @id_shop INT = 1
EXEC [create_employee] @name, @id_shop
GO

--10
CREATE PROCEDURE [task10] AS BEGIN
	SELECT equipment.[name]
	FROM equipment
	WHERE next_maintenance_date BETWEEN GETDATE() AND DATEADD(week, 1, GETDATE())
END

EXEC [task10]
GO

--11
CREATE PROCEDURE [task11](
	@breakdown NVARCHAR(50)
) AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [b].[id]
    FROM breakdown as [b]
    WHERE [b].[name] = @breakdown

	IF @check = -1 BEGIN
        PRINT CONCAT(N'поломки ', @breakdown, N' не суеществует')
        RETURN
    END

	SELECT e.[name]
	FROM equipment as [e] INNER JOIN
	breakdown as [b] on [b].[id] = [e].[breakdown]
	WHERE [b].[name] = @breakdown
END

DECLARE @breakdown NVARCHAR(50) = N'Поломка 2'
EXEC [task11] @breakdown
GO

--12
CREATE PROCEDURE [ALLbreakdown] AS BEGIN
	SELECT *
	FROM breakdown
END

EXEC [ALLbreakdown]
GO

--13
CREATE PROCEDURE [task13] (
	@equipment_id INT,
	@repair_start_date DATE
)AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [b].[id]
    FROM breakdown as [b]
    WHERE [b].[name] = @breakdown

	IF @check = -1 BEGIN
        PRINT CONCAT(N'поломки ', @breakdown, N' не суеществует')
        RETURN
    END

	UPDATE [equipment]
    SET repair_start_date = @repair_start_date
    WHERE id = @equipment_id

	SELECT *
	FROM [equipment]
END

DECLARE @equipment_id INT = 1, @repair_start_date DATE = '2024-11-25'
EXEC [task13] @equipment_id,@repair_start_date
GO

--14
CREATE PROCEDURE [task14] (
	@equipment_id INT
)AS BEGIN

	DECLARE @check INT = -1
    SELECT @check = [e].[id]
    FROM [equipment] as [e]
    WHERE [e].[id] = @equipment_id

	IF @check = -1 BEGIN
        PRINT CONCAT(N'поломки ', @equipment_id, N' не суеществует')
        RETURN
    END

	UPDATE [equipment]
    SET repair_start_date = NULL,
    repair_end_date_date = GETDATE()
    WHERE id = @equipment_id

	SELECT *
	FROM [equipment]
END

DECLARE @equipment_id INT = 2, @repair_start_date DATE = NULL
EXEC [task14] @equipment_id
GO

--15

CREATE PROCEDURE [create_employee](
	@id_product INT, @id_shop INT, @id_provider INT, @count_product INT, @total_cost MONEY
) AS BEGIN

	DECLARE @check1 INT = -1
    SELECT @check1 = [s].[id]
    FROM [shop] as [s]
    WHERE [s].[id] = @id_shop

	DECLARE @check2 INT = -1
    SELECT @check2 = [s].[id]
    FROM product as [s]
    WHERE [s].[id] = @id_product

	DECLARE @check3 INT = -1
    SELECT @check3 = [s].[id]
    FROM [provider] as [s]
    WHERE [s].[id] = @id_provider

	IF @check1 = -1 BEGIN
        PRINT CONCAT(N'магазина ', @id_shop, N' не суеществует')
        RETURN
    END

	IF @check2 = -1 BEGIN
        PRINT CONCAT(N'продукта ', @id_product, N' не суеществует')
        RETURN
    END

	IF @check3 = -1 BEGIN
        PRINT CONCAT(N'поставщика ', @id_provider, N' не суеществует')
        RETURN
    END

    INSERT INTO [delivery] 
    VALUES (@id_product, @id_shop,@id_provider, @count_product,@total_cost)

	SELECT *
	FROM [delivery]

END

DECLARE @id_product INT = 1, @id_shop INT = 1,@id_provider int =1, @count_product INT = 111, @total_cost MONEY = 1215
EXEC [create_employee] @id_product, @id_shop,@id_provider,@count_product,@total_cost
GO

--16
CREATE PROCEDURE [task16]
    @date DATE
AS
BEGIN
    SELECT SUM([total_cost]) AS [сумма]
    FROM sales
    WHERE [date] = @date
END

DECLARE @date DATE = '2024-03-26'
EXEC [task16] @date
GO