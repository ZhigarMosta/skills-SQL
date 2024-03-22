IF DB_ID(N'db_7') IS NULL BEGIN
	CREATE DATABASE [db_7]
END ELSE BEGIN
	PRINT N'База данных db_7 уже существует'
END

USE db_7

IF OBJECT_ID(N'patient') IS NULL BEGIN
	CREATE TABLE patient(
		[id] INT NOT NULL IDENTITY,
		[p_full_name] NVARCHAR(50) NOT NULL,
		[p_category] NVARCHAR(50) NOT NULL,
		[p_date] DATE NOT NULL

		CONSTRAINT [PK_id_patient] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица patient уже существует'
END

IF OBJECT_ID(N'doctor') IS NULL BEGIN
	CREATE TABLE doctor(
		[id] INT NOT NULL IDENTITY,
		[d_full_name] NVARCHAR(50) NOT NULL,
		[d_speciality] NVARCHAR(50) NOT NULL,
		[d_experience] SMALLINT NOT NULL,
		[d_date] DATE NOT NULL

		CONSTRAINT [PK_id_doctor] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица doctor уже существует'
END

IF OBJECT_ID(N'reception') IS NULL BEGIN
	CREATE TABLE reception(
		[id] INT NOT NULL IDENTITY,
		[id_p] INT NOT NULL,
		[id_d] INT NOT NULL,
		[r_date] DATETIME NOT NULL,
		[id_cabinet] SMALLINT NOT NULL

		CONSTRAINT [PK_id_reception] PRIMARY KEY([id]),

		CONSTRAINT [FK_patient] FOREIGN KEY ([id_p])
			REFERENCES patient ([id]),

		CONSTRAINT [FK_doctor] FOREIGN KEY ([id_d])
			REFERENCES doctor ([id])

	)
END ELSE BEGIN
	PRINT N'Таблица doctor уже существует'
END

INSERT INTO
	patient --фио категория дата рождения
VALUES
	(N'Крылов Матвей Кириллович', N'сторонний', N'1975-01-05'),
	(N'Серова Кристина Романовна', N'сторонний', N'1974-01-05'),
	(N'Иванов Cван Пванович', N'пенсионер', N'2000-11-05'),
	(N'Галкин Артём Артёмович', N'пенсионер', N'2005-07-13'),
	(N'Соловьев Лев Матвеевич', N'сторонний', N'1990-08-05'),
	(N'Иванова Александра Алиевна', N'пенсионер', N'1977-02-19'),
	(N'Самсонов Даниил Владиславович', N'без ноги', N'2019-10-25'),
	(N'Смирнова Дарина Михайловна', N'без руки', N'1981-05-06'),
	(N'Петрова Ульяна Яновна', N'без рук', N'2021-08-13'),
	(N'Сидоров Яромир Маркович', N'без ног', N'1977-04-16'),
	(N'Гордеев Артём Вадимович', N'без рук и ног', N'1975-05-04'),
	(N'Мешалкина Оксана Борисовна', N'пенсионер', N'1984-07-13'),
	(N'Андреев Дмитрий Даниилович', N'пенсионер', N'1969-07-13'),
	(N'Анисимов Матвей Кириллович', N'пенсионер', N'1964-07-13'),
	(N'Архипов Дмитрий Кириллович', N'пенсионер', N'1967-07-13')

INSERT INTO
	doctor --фио специальность стаж дата_рождения
VALUES
	(N'Никифорова Екатерина Андреевна', N'терапевт', 1, N'2001-03-17'),
	(N'Бондарева Вероника Михайловна', N'терапевт',50, N'2003-10-21'),
	(N'Костина Софья Романовна', N'терапевт', 0, N'1978-03-12'),
	(N'Иванов Константин Ярославович', N'терапевт', 80, N'1995-01-30'),
	(N'Орлова Анна Давидовна', N'окулист', 6, N'2004-07-25'),
	(N'Орлова Анна Давидовна', N'окулист', 5, N'1990-09-03'),
	(N'Миронов Артём Семёнович', N'окулист', 0, N'1993-06-16'),
	(N'Иванов Иван Иванович', N'окулист', 40, N'2014-09-13'),
	(N'Белова Мария Фёдоровна', N'диетолог', 2, N'1981-04-26'),
	(N'Софронов Елисей Матвеевич', N'диетолог', 3, N'1981-03-22'),
	(N'Мухина Мария Михайловна', N'диетолог', 4, N'1982-09-03')

INSERT INTO
	reception ([id_p], [id_d], [r_date], [id_cabinet]) -- id_p id_d дата кабинет       3 4 6 7 6 9 10
VALUES
	(1, 1, N'2023-01-19', 1),
	(2, 2, N'2023-01-10', 2),
	(3, 3, N'2023-01-20', 3),
	(4, 4, N'1974-11-29', 4),
	(5, 5, N'1992-03-04', 5),
	(6, 6, N'1983-03-15', 6),
	(7, 7, N'2014-09-10', 7),
	(8, 8, N'1995-07-17', 8),
	(9, 9, N'2011-11-26', 9),
	(10, 10, N'2024-01-14', 10),
	(11, 11, N'1984-06-21', 11),
	(1, 2, N'2005-08-20', 12),
	(2, 3, N'1974-03-01', 13),
	(3, 4, N'1996-05-25', 14),
	(4, 5, N'1991-02-18', 15),
	(5, 6, N'1979-09-04', 16),
	(6, 7, N'2023-12-29', 17),
	(7, 8, N'2012-02-10', 18),
	(8, 9, N'2005-06-16', 19),
	(9, 10, N'2020-08-30', 20),
	(10, 11, N'1987-03-24', 21),
	(11, 1, N'1976-06-08', 22),
	(1, 3, N'1979-06-24', 23),
	(2, 4, N'1997-04-03', 24),
	(3, 5, N'1980-09-11', 25),
	(4, 6, N'1999-10-15', 26),
	(5, 7, N'2007-03-09', 27),
	(6, 8, N'2005-03-22', 28),
	(7, 9, N'2001-12-25', 29),
	(8, 10, N'2020-10-04', 30),
	(9, 11, N'1924-09-20', 31),
	(10, 1, N'2024-09-06', 32),
	(11, 2, N'2024-06-28', 33),
	(2, 7, N'2024-06-28', 33),
	(3, 7, N'2024-06-28', 33),
	(4, 7, N'2024-06-28', 33),
	(5, 7, N'2024-06-28', 33),
	(6, 8, N'2024-06-28', 33),
	(7, 8, N'2024-06-28', 33),
	(3, 6, N'2024-06-28', 33),
	(3, 9, N'2024-06-28', 33),
	(1, 10, N'2024-06-28', 33),
	(3, 10, N'2024-06-28', 33),
	(12, 1, N'2024-06-28', 33),
	(12, 6, N'2024-06-28', 33),
	(12, 6, N'2024-06-28', 33),
	(13, 6, N'2024-06-28', 33),
	(13, 6, N'2024-06-28', 33),
	(13, 6, N'2024-06-28', 33),
	(13, 6, N'2024-06-28', 33),
	(14, 7, N'2024-06-28', 33),
	(14, 7, N'2024-06-28', 33),
	(14, 7, N'2024-06-28', 33),
	(15, 6, N'2024-06-28', 33),
	(15, 7, N'2024-06-28', 33),
	(15, 8, N'2024-06-28', 33),
	(1, 1, N'2023-06-28', 33),
	(1, 1, N'2023-06-28', 33),
	(1, 8, N'2024-03-06 20:31:00.000', 65),
	(2, 8, N'2024-03-04 10:00:00.000', 55),
	(3, 8, N'2024-03-05 10:30:00.000', 45),
	(4, 8, N'2024-03-09 15:15:00.000', 22)

drop table [reception] , doctor, patient

--1
SELECT [p].[id], [p].[p_full_name] as [ФИО], count(*) as [число приемов], N'пациент' as [тип]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
WHERE YEAR([r].[r_date]) = YEAR(GETDATE())
GROUP BY [p].[id], [p].[p_full_name]

UNION

SELECT [d].[id] , [d].[d_full_name], count(*), N'врач'
FROM [reception] AS [r]
INNER JOIN [doctor]AS[d] ON [d].[id] = [r].[id_d]
WHERE YEAR([r].[r_date]) = YEAR(GETDATE())
GROUP BY [d].[id],[d].[d_full_name]

--2
SELECT [d].[id], [d].[d_full_name] AS [ФИО], count(*) as [колличество принятых пациентов]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
INNER JOIN [doctor] AS [d] ON [d].[id] = [r].[id_d]
WHERE [d].[d_speciality] = N'терапевт' and [p].[p_category] != N'сторонний'
and([r].[r_date] BETWEEN DATEFROMPARTS(YEAR(DATEADD(YEAR, -1, GETDATE())), 1, 1) and DATEFROMPARTS(YEAR(DATEADD(YEAR, -1, GETDATE())), 1, 31))
GROUP BY [d].[id], [d].[d_full_name],[r].[r_date]
HAVING count(*)/1 > 0.75
ORDER BY [ФИО]

--3
SELECT [p].[p_category] as [категория пациента],COUNT(*) AS [количество приемов пациентов и количество врачей принявших пациентов ]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
INNER JOIN [doctor] AS [d] ON [d].[id] = [r].[id_d]
WHERE [p].[p_date] > '1976-01-01' and [d].[d_experience] > 1
GROUP BY [p].[p_category]

--4
DECLARE @speciality NVARCHAR(50)
DECLARE @patientsCount INT

SELECT @speciality = [d].[d_speciality]
FROM [doctor] as [d]
WHERE [d].[d_full_name] = N'Иванов Иван Иванович'


SELECT @patientsCount = COUNT(r.id)
FROM [doctor] as [d]
JOIN [reception] as [r] ON [d].[id] = [r].[id_d]
JOIN [patient] as [p] ON [r].[id_p] = [p].[id]
WHERE [d].[d_full_name] = N'Иванов Иван Иванович'
AND YEAR([r].[r_date]) = YEAR(GETDATE())

SELECT [d].[id], [d].[d_full_name] AS[ФИО], COUNT([r].[id]) AS [число принятых пациентов]
FROM [doctor] as [d]
INNER JOIN [reception] as [r] ON [d].[id] = [r].[id_d]
WHERE [d].[d_speciality] = @speciality
AND YEAR([r].[r_date]) = YEAR(GETDATE())
GROUP BY [d].[id], [d].[d_full_name]
HAVING COUNT([r].[id]) > @patientsCount

--5
SELECT [p].[id], [p].[p_full_name] AS ФИО
FROM [patient] as [p]
WHERE [p].[id] NOT IN (
    SELECT [r].[id_p]
    FROM [reception] AS [r]
    INNER JOIN [doctor] AS [d] ON [r].[id_d] = [d].[id]
    INNER JOIN [patient] AS [p1] ON [r].[id_p] = [p1].[id]
    WHERE [p1].[p_full_name] != N'Иванов С%П%'
    AND YEAR([r].[r_date]) = YEAR(GETDATE())
)
ORDER BY [p].[id] DESC

--6
SELECT DISTINCT [p].[id], [p].[p_full_name] AS [ФИО]
FROM [reception] AS [r]
INNER JOIN [doctor] AS [d] ON [r].[id_d] = [d].[id]
INNER JOIN [patient] AS [p] ON [r].[id_p] = [p].[id]
WHERE [p].[p_category] = N'пенсионер' AND YEAR(GETDATE()) = YEAR([r].[r_date])
and (
	[p].[id] NOT IN (
	SELECT [r].[id_p]
	FROM [reception] as [r]
	INNER JOIN [doctor] as [d] ON [r].[id_d] = [d].[id]
	WHERE [d].[d_speciality] = N'терапевт'
	) or [p].[id] IN
(
	SELECT [r].[id_p]
	FROM [reception] as [r]
	INNER JOIN [doctor] as [d] ON [r].[id_d] = [d].[id]
	WHERE [d].[d_speciality] = N'окулист'
	GROUP BY [r].[id_p]
	HAVING COUNT([r].[id_p]) > 1)
	)
ORDER BY [p].[p_full_name]

--7
SELECT DISTINCT [tds].[patient_name] AS [ФИО пациента], 
	CASE 
		WHEN [tds].[количество разных посещений врача] = 3 THEN N'посетил 3 разных врачей'
		ELSE N'посетил только врача ' + [d].[d_full_name]
	END AS [категория пациента],
	CASE
		WHEN [tds].[количество разных посещений врача] = 3 THEN [tds].[количество разных посещений врача]
		ELSE [tds].[количесво всех посещений врача]
	END AS [количество посещений]
FROM (
	SELECT [p].[id] AS [patient_id], [p].[p_full_name] AS [patient_name], COUNT(DISTINCT [r].[id_d]) AS [количество разных посещений врача],
	COUNT(*) AS [количесво всех посещений врача]
	FROM [patient] AS [p]
	INNER JOIN [reception] as [r] ON [p].[id] = [r].[id_p]
	WHERE DATEDIFF(YEAR, [p].[p_date], GETDATE()) BETWEEN 55 AND 60
	GROUP BY [p].[id], [p].[p_full_name]
) AS [tds] -- временный набор данных
INNER JOIN [reception] AS [r] ON [tds].[patient_id] = [r].[id_p]
INNER JOIN [doctor] AS [d] ON [r].[id_d] = [d].[id]
WHERE [tds].[количество разных посещений врача] = 3 OR [tds].[количесво всех посещений врача] >= 3
ORDER BY [категория пациента], [количество посещений] DESC


SELECT
	[p].[p_full_name] AS [ФИО пациента],
    N'посетил только врача ' + [d].[d_full_name]  AS [категория пациента],
    COUNT(*) AS [количество посещений]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
INNER JOIN [doctor] AS [d] ON [r].[id_d] = [d].[id]
WHERE DATEDIFF(YEAR, [p].[p_date], GETDATE()) BETWEEN 55 AND 60
GROUP BY [p].[p_full_name], [d].[d_full_name]
HAVING COUNT(*) >= 3

UNION

SELECT [p].[p_full_name] AS [ФИО пациента], 
    N'посетил 3 разных врачей' AS [категория пациента],
    COUNT(*) AS [количество посещений]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
WHERE DATEDIFF(YEAR, [p].[p_date], GETDATE()) BETWEEN 55 AND 60
GROUP BY [p].[p_full_name]
HAVING COUNT(DISTINCT [r].[id_d]) = 3
ORDER BY [категория пациента], [количество посещений] DESC

--8
SELECT 
    DATENAME(MONTH, DATEADD(MONTH, MONTH([r_date]), -1)) AS [Название месяца],
    N'Самый загруженный день' AS [Тип],
	DATENAME(DAY, MAX([r_date])) + ' ' + DATENAME(WEEKDAY, MAX([r_date])) AS [Дата],
    COUNT(*) AS [Количество посещений]
FROM [reception]
WHERE YEAR([r_date]) = YEAR(GETDATE()) - 1
GROUP BY MONTH(r_date), DAY([r_date])
HAVING COUNT(*) = (
    SELECT MAX([visits_count])
    FROM (
        SELECT DAY([r_date]) AS day, COUNT(*) AS [visits_count]
        FROM [reception]
        WHERE YEAR([r_date]) = YEAR(GETDATE()) - 1
        GROUP BY MONTH([r_date]), DAY([r_date])
    ) AS [visit_counts]
)

UNION

SELECT 
    DATENAME(MONTH, DATEADD(MONTH, MONTH([r_date]), -1)) AS [Название месяца],
    N'Самый свободный день' AS [Тип],
	DATENAME(DAY, MIN([r_date])) + ' '+ DATENAME(WEEKDAY, MIN([r_date])) AS [Дата],
    COUNT(*) AS [Количество посещений]
FROM [reception]
WHERE YEAR([r_date]) = YEAR(GETDATE()) - 1
GROUP BY MONTH([r_date]), DAY([r_date])
HAVING COUNT(*) = (
    SELECT MIN([visits_count])
    FROM (
        SELECT DAY([r_date]) AS day, COUNT(*) AS [visits_count]
        FROM [reception]
        WHERE YEAR([r_date]) = YEAR(GETDATE()) - 1
        GROUP BY MONTH([r_date]), DAY([r_date])
    ) AS [visit_counts]
)
ORDER BY [Название месяца]

--9
SELECT 
  [d1].[id],
  [d1].[d_full_name] AS [ФИО ученика],
  [d1].[d_speciality] AS [специальность],
  [d1].[d_experience] AS [стаж],
  [d2].[id],
  [d2].[d_full_name] AS [ФИО ментора],
  [d2].[d_speciality] AS [специальность],
  [d2].[d_experience] AS [стаж]
FROM [doctor] AS [d1]
INNER JOIN [doctor] AS [d2] ON [d1].[d_speciality] = [d2].[d_speciality] AND [d1].[d_experience] <= [d2].[d_experience] - 10
WHERE [d1].[d_experience] = 0 OR [d1].[d_experience] = 1
ORDER BY [d1].[d_full_name], [d1].[d_experience], [d2].[d_experience] DESC

--10
SELECT
	DATENAME(WEEKDAY, [r_date]) AS [день],
	[r].[id_cabinet] AS [номер кабинета],
	CAST([r_date] AS TIME) AS [время приёма],
	[p].[p_full_name] AS [ФИО пациента]
FROM [patient] AS [p]
INNER JOIN [reception] AS [r] ON [p].[id] = [r].[id_p]
INNER JOIN [doctor] AS [d] ON [r].[id_d] = [d].[id]
WHERE [d].[d_full_name] = N'Иванов Иван Иванович'
AND DATENAME(WEEK, [r_date]) = DATENAME(WEEK, GETDATE())

SELECT GETDATE(),
SYSDATETIME(),
YEAR(GETDATE()),
MONTH(GETDATE()),
DAY(GETDATE()),
DATENAME(MONTH, GETDATE()),
DATENAME(WEEKDAY, GETDATE()),
DATEPART(WEEK,GETDATE()),
DATEADD(YEAR, 0,GETDATE()) as [sa],--ДОБАВЛЕНИЕ ДАТЕ
DATEDIFF(YEAR,GETDATE(), N'2020-01-01'),-- РАЗНИЦА ДАТ
DATEFROMPARTS(2000,03,02),--СБОР ДАТЫ
EOMONTH(GETDATE()),--ПОСЛЕДНЯЯ ДАТА МЕСЯЦА
ISDATE(N'2020-01-01')--ВАЛИДАЦИЯ ДАТЫ

SELECT DATENAME(WEEK, GETDATE())

SELECT DATENAME(MONTH, DATEADD(MONTH, MONTH(GETDATE()), -1)) AS [Название месяца]


-------------------------------------------------------------------------------------------------------------------------------------------------

--1
DECLARE @number1 INT = 2
DECLARE @number2 INT = 2
IF @number1 > @number2 BEGIN
	PRINT 1
END IF @number1 < @number2 BEGIN
	PRINT 2
END ELSE BEGIN
	PRINT 0
END

-- 2
DECLARE @number1 INT = 4
DECLARE @number2 INT = 2
DECLARE @number3 INT = 3
IF @number1 > @number2 AND @number1 > @number3 BEGIN
	PRINT @number1
END IF @number2 > @number1 AND @number2 > @number3 BEGIN
	PRINT @number2
END IF @number3 > @number1 AND @number3 > @number2 BEGIN
	PRINT @number3
END

--3
DECLARE @a INT = 111
DECLARE @b INT = 11
DECLARE @c INT = 1
IF @a < @c + @b AND @b < @a + @c AND @c < @a + @b BEGIN
	PRINT N'YES'
END ELSE BEGIN
	PRINT N'NO'
END

-- 4
DECLARE @number1 INT = 1
DECLARE @number2 INT = 1
DECLARE @number3 INT = 1
IF @number1 = @number2 AND @number1 = @number3 AND @number2 = @number3 BEGIN
	PRINT 3
END IF (@number1 = @number2 AND @number1 != @number3) OR (@number3 = @number1 AND @number2 != @number1) OR (@number3 = @number2 AND @number2 != @number1)BEGIN
	PRINT 2
END IF @number1 != @number2 AND @number2 != @number3 AND @number1 != @number3 BEGIN
	PRINT 0
END

--5
DECLARE @a INT = 2
DECLARE @b INT = 2
IF @a = 0 AND @b != 0 BEGIN
	PRINT N'NO'
END IF @a = 0 AND @b = 0 BEGIN
	PRINT N'INF'
END IF @a != 0 BEGIN
		IF -(@b / @a) = -(@b / @a) / 1 BEGIN
			PRINT -(@b / @a)
	END ELSE BEGIN
		PRINT N'NO'
	END
END

-- 6
DECLARE @a INT = 1
DECLARE @b INT = 3
DECLARE @c INT = -4
DECLARE @D DECIMAL = (@b * @b) - 4 * @a * @c

IF @D > 0 BEGIN
	SELECT ((@b * (-1)) + SQRT(@D)) / (2 * @a) AS [X1],
	((@b * (-1)) - SQRT(@D)) / (2 * @a) AS [X2]
END ELSE IF @D = 0 BEGIN
	SELECT (@b) / (2 * @a) AS [X]
END

--7
DECLARE @n INT = 21
IF @n % 10 = 1 AND @n <> 11 BEGIN
	PRINT CONCAT(N'На лугу пасется ',@n, N' корова')
END IF @n % 10 >= 2 AND @n % 10 <= 4 AND (@n < 10 OR @n > 20) BEGIN
	PRINT CONCAT(N'На лугу пасется ', @n, N' коровы')
END ELSE BEGIN
	PRINT CONCAT(N'На лугу пасется ', @n, N' коров')
END

-- 8
DECLARE @a INT = 13
DECLARE @b INT = 50
DECLARE @c INT = 60

IF (@a / 2 = 1 OR @b / 2 = 1 OR @c / 2 = 1) AND (@a / 2 != 1 OR @b / 2 != 1 OR @c / 2 != 1) SELECT N'YES'
ELSE SELECT N'NO'

--9
DECLARE @year INT = 2077
IF @year % 4 = 0 AND @year % 100 <> 0 OR @year % 400 = 0 BEGIN
	PRINT N'YES'
END ELSE BEGIN
	PRINT N'NO'
END

--10
DECLARE @k INT = 11
IF @k < 0 OR @k = 0 OR @k = 1 OR @k = 2 OR @k = 4 OR @k = 7 BEGIN
	PRINT N'NO'
END ELSE BEGIN
	PRINT N'YES'
END

--1
DECLARE @number2 INT = 1
WHILE @number2 * @number2 <= 1024 BEGIN
	SET @number2 = @number2 + 1
	PRINT @number2 * @number2
END

--2
DECLARE @number INT = 1024
DECLARE @constZ1 INT = 0
DECLARE @constZ2 INT = 0
DECLARE @constO INT = 1
WHILE @number != 0 BEGIN
	IF @number % 2 = 0 BEGIN
		SET @constZ1 = 0
	END ELSE BEGIN
		SET @constZ1 = 1
		SET @constZ2 += @constO * @constZ1
		
	END
	SET @constO *= 10
	SET @number /= 2
END
PRINT @constZ2
PRINT REVERSE(@constZ2)

--3
DECLARE @number INT = 8888
DECLARE @sum INT = 0
DECLARE @a INT = 0
WHILE @number != 0 BEGIN
	SET @a = @number % 10
	SET @sum += @a
	SET @number /= 10
END
PRINT @sum

--4
DECLARE @number INT = 102548
DECLARE @min INT = 9
DECLARE @max INT = 0
WHILE @number != 0 BEGIN
	IF @number % 10 > @max BEGIN
		SET @max = @number % 10
	END
	IF @number % 10 < @min BEGIN
		SET @min = @number % 10
	END
	SET @number /= 10
END
PRINT CONCAT(@min, N' ', @max)

--5
DECLARE @n INT = 10005
DECLARE @count INT = 0
WHILE @n != 0 BEGIN
	IF @n % 10 = 0 BEGIN
		SET @count += 1
	END
	SET @n /= 10
END
PRINT @count

--6
DECLARE @k INT = 1000
DECLARE @countN INT = 0
DECLARE @countF INT = 0
DECLARE @n INT = 0
DECLARE @f INT = 0
WHILE @k != 0 BEGIN
	SET @n = @countN
	SET @f = 0
	WHILE @n > 0 BEGIN
		SET @f = @f * 10 + @n % 10
		SET @n /= 10
	END
	IF @countN = @f BEGIN
		SET @countF += 1
	END
	SET @k /= 10
END
PRINT @countF

--7
DECLARE @number INT = 12345
DECLARE @reversedNum INT = 0
WHILE @number > 0 BEGIN
	SET @reversedNum = @reversedNum *10 +(@number % 10)
	SET @number = @number/10
END
PRINT @reversedNum

DECLARE @number INT = 12345
PRINT REVERSE(@number)

--8
DECLARE @n INT = 2048
DECLARE @const INT = 2
WHILE @const < @n BEGIN
	PRINT @const
	SET @const *= 2
END

--9
DECLARE @numbr INT = 15
DECLARE @minDel INT = 2
WHILE @numbr % @minDel != 0 BEGIN
	SET @minDel += 1
END
PRINT @minDel

--10
DECLARE @x FLOAT = 1
DECLARE @y INT = 100
DECLARE @numbr INT = 1
WHILE @x < @y BEGIN
	SET @x *= 1.1
	SET @numbr += 1
END
PRINT @numbr
