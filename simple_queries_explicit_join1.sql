IF DB_ID(N'db') IS NULL BEGIN
	CREATE DATABASE [db]
END ELSE BEGIN
	PRINT N'База данных db уже существует'
END

USE db

IF OBJECT_ID(N'position') IS NULL BEGIN
	CREATE TABLE position(
		[id] INT NOT NULL IDENTITY,
		[p_name] NVARCHAR(50) NOT NULL,
		[p_salary] MONEY NOT NULL

		CONSTRAINT [PK_id_position] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица position уже существует'
END

IF OBJECT_ID(N'city') IS NULL BEGIN
	CREATE TABLE city(
		[id] INT NOT NULL IDENTITY,
		[c_name] NVARCHAR(50) NOT NULL,

		CONSTRAINT [PK_id_city] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица city уже существует'
END

IF OBJECT_ID(N'department') IS NULL BEGIN
	CREATE TABLE department(
		[id] INT NOT NULL IDENTITY,
		[d_name] NVARCHAR(50) NOT NULL

		CONSTRAINT [PK_id_department] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица department уже существует'
END

IF OBJECT_ID(N'employee') IS NULL BEGIN
	CREATE TABLE employee(
		[id] INT NOT NULL IDENTITY,
		[e_surname] NVARCHAR(50) NOT NULL,
		[e_name] NVARCHAR(50) NOT NULL,
		[e_patronymics] NVARCHAR(50) NOT NULL,
		[e_gender] NVARCHAR(1) NOT NULL,
		[e_dateBirth] DATE NOT NULL,
		[e_department] INT NOT NULL,
		[e_city] INT NOT NULL

		CONSTRAINT [PK_id_employee] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица employee уже существует'
END

IF OBJECT_ID(N'storyPosition') IS NULL BEGIN
	CREATE TABLE storyPosition(
		[id] INT NOT NULL IDENTITY,
		[s_dateStart] DATE NOT NULL,
		[s_dateEnd] DATE NOT NULL,
		[s_employee] INT NOT NULL,
		[s_position] INT NOT NULL

		CONSTRAINT [PK_id_storyPosition] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица storyPosition уже существует'
END

IF OBJECT_ID(N'dismissal') IS NULL BEGIN
	CREATE TABLE dismissal(
		[id] INT NOT NULL,
		[d_data] DATE NOT NULL,
		[e_cause] NVARCHAR(max) NOT NULL,

		CONSTRAINT [PK_id_dismissal] PRIMARY KEY([id])

	)
END ELSE BEGIN
	PRINT N'Таблица dismissal уже существует'
END

ALTER TABLE employee
ADD CONSTRAINT [employee_FK_department_id] FOREIGN KEY ([e_department])
REFERENCES department ([id])
ON UPDATE CASCADE,

CONSTRAINT [employee_FK_city_id] FOREIGN KEY ([e_city])
REFERENCES [city] ([id])
ON UPDATE CASCADE

ALTER TABLE storyPosition
ADD CONSTRAINT [storyPosition_FK_employee_id] FOREIGN KEY ([s_employee])
REFERENCES [employee] ([id])
ON UPDATE CASCADE,

CONSTRAINT [storyPosition_FK_position_id] FOREIGN KEY ([s_position])
REFERENCES [position] ([id])
ON UPDATE CASCADE

ALTER TABLE dismissal
ADD CONSTRAINT [dismissal_FK_employee_id] FOREIGN KEY ([id])
REFERENCES [employee] ([id])
ON UPDATE CASCADE

INSERT INTO
	[position]
VALUES
	(N'Главный', 1),
	(N'Не глаыный', 2),
	(N'Зам не главного', 200000),
	(N'Зам главного', 2000000),
	(N'мл прогер', 2000000),
	(N'Прогер', 1000000)

INSERT INTO
	city
VALUES
	(N'Москва'),
	(N'Хабаровск'),
	(N'Питер'),
	(N'Челяба')

INSERT INTO
	department
VALUES
	(N'Не главный отдел'),
	(N'Глав отдел'),
	(N'Просто отдел'),
	(N'Отдел прогеров')

INSERT INTO
	employee
VALUES
	(N'Иванов  ',N'Иван  ',N'Иванович',N'м',N'2001-05-05',1,2),
	(N'Сидоров ',N'Адольф ',N'Андреевич',N'м',N'2002-04-05',2,3),
	(N'Побанов',N'Арнольд ',N'Яковлевич',N'м',N'2003-03-05',3,4),
	(N'Дмитриев',N'Арсен ',N'Иванович',N'м',N'2004-01-05',4,1),
	(N'Поршков',N'Аполлон ',N'Русланович',N'м',N'2005-02-05',1,2),
	(N'Дмитриев',N'Адольф ',N'Андреевич',N'м',N'2000-01-01',4,1),
	(N'Рысков',N'Ефим',N'Максимович',N'м',N'2000-01-01',3,4),
	(N'Бахтдавлатов',N'Тимофей ',N'Иванович',N'м',N'2000-01-01',3,4),
	(N'Лаушкин',N'Герман',N'Борисович',N'м',N'2000-01-01',3,4),
	(N'Саламов ',N'Роберт',N'Олегович',N'м',N'2000-01-01',3,4)

INSERT INTO
	storyPosition
VALUES
	(N'2002-05-05',N'2024-02-05',1,1),
	(N'2024-02-05',N'2024-02-06',1,6),
	(N'2006-05-05',N'2006-05-06',2,2),
	(N'2018-05-05',N'2023-05-06',3,3),
	(N'2011-05-05',N'2020-05-06',4,4),
	(N'2011-05-05',N'2012-05-06',5,5),
	(N'2010-05-05',N'2023-11-06',6,6)

INSERT INTO
	dismissal
VALUES
	(2,N'2006-05-06',N'обидел не главного'),
	(3,N'2023-05-06',N'уволился сам'),
	(4,N'2020-05-06',N'никого не увольнял'),
	(5,'2012-05-06',N'слишком хорошо прогал')

--drop table [city], dismissal, storyPosition, employee, [position],department

--1
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [p].[p_name] as [должность] 
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
ORDER BY [ФИО],[должность]

--2
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [p].[p_salary] as [оклад] 
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
ORDER BY [оклад] DESC

--3
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО]
FROM [dismissal] as [d] INNER JOIN [employee] as [e] ON [e].[id] = [d].[id]
WHERE [d].[d_data] >= DATEADD(YEAR, -3, GETDATE())
ORDER BY [d].[d_data]

--4
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [d].[d_name] as [отдел] 
FROM [employee] as [e] INNER JOIN [department] as [d] ON [e].[e_department]=[d].[id]

--5
SELECT COUNT([e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics]) as [количесво сотрудников], [d].[d_name] as [отдел] 
FROM [employee] as [e] INNER JOIN [department] as [d] ON [e].[e_department]=[d].[id]
GROUP BY [d].[d_name]

--6
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [p].[p_salary] as [оклад],[p].[p_name]
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
WHERE [e].[e_surname] like N'П%' and [p].[p_salary] > 100000 and ([p].[p_name] = N'мл прогер' or [p].[p_name] = N'Прогер')

--7
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [p].[p_name] as [должность] 
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
WHERE DATEDIFF( year,[s].[s_dateStart], [s].[s_dateEnd]) >= 5

--8
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [p].[p_name] as [должность],
DATEDIFF( year,[s].[s_dateStart], [s].[s_dateEnd]) as [стаж работы в годах]
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
WHERE [e].[e_surname] = N'Иванов' and [e].[e_name] = N'Иван' and [e].[e_patronymics] = N'Иванович'

--9
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], COUNT([p].[p_name]) as [количество должностей должность],
SUM(DATEDIFF( year,[s].[s_dateStart], [s].[s_dateEnd])) as [общий стаж работы в годах]
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on[s].[s_employee] = [e].[id]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
WHERE [e].[e_surname] = N'Иванов' and [e].[e_name] = N'Иван' and [e].[e_patronymics] = N'Иванович'
GROUP BY [e].[e_surname],[e].[e_name],[e].[e_patronymics]

--10
SELECT YEAR([d].[d_data]) AS [года], COUNT(*) AS [количесво уволленных]
FROM dismissal as [d]
GROUP BY YEAR([d].[d_data])
ORDER BY [года] DESC

--11
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [c].[c_name] as [город]
FROM [employee] as [e] INNER JOIN [city] as [c] on [e].[e_city] = [c].[id]

--12
SELECT [e].[e_surname] +''+ [e].[e_name] +''+ [e].[e_patronymics] as [ФИО], [c].[c_name] as [город],
[p].[p_name] as [должность],
DATEDIFF( year,[s].[s_dateStart], [s].[s_dateEnd]) as [стаж работы]
FROM [city] as [c] INNER JOIN [employee] as [e] on [c].[id] = [e].[e_city]
INNER JOIN [storyPosition] as [s] on [e].[id] = [s].[s_employee]
INNER JOIN [position] as [p] on [s].[s_position] = [p].[id]
WHERE DATEDIFF( year,[s].[s_dateStart], [s].[s_dateEnd]) >= 10 and [c].[c_name] = N'Москва'
and ([p].[p_name] = N'мл прогер' or [p].[p_name] = N'Прогер')

--13
SELECT [c].[c_name] as [город], COUNT([e].[e_surname]) as [количесво сотрудников]
FROM [city] as [c] INNER JOIN [employee] as [e] on [c].[id] = [e].[e_city]
GROUP BY [c].[c_name]
HAVING COUNT([e].[e_surname]) > 4
ORDER BY [количесво сотрудников] DESC

--14
SELECT YEAR(GETDATE()) - AVG(YEAR([e].[e_dateBirth])) as [средний возраст уволенных сотрудников]
FROM [dismissal] as [d] INNER JOIN [employee] as [e] on [d].[id] = [e].[id]

--15
SELECT CONCAT([e].[e_surname], ' ', LEFT([e].[e_name], 1), '.', LEFT([e].[e_patronymics], 1), '.') as [ФИО],
[e].[e_gender] as [Пол],
DATEDIFF(YEAR, [e].[e_dateBirth], GETDATE()) as [Возраст],
DATEDIFF(MONTH, MIN([s].[s_dateStart]), MAX([s].[s_dateEnd])) / 12 as [Общий стаж]
FROM [employee] as [e] INNER JOIN [storyPosition] as [s] on [e].[id] = [s].[s_employee]
INNER JOIN dismissal as [d] on [e].[id] = [d].[id]
WHERE [d].[d_data] = (SELECT MAX([d].[d_data]) FROM dismissal as [d])
GROUP BY [e].[e_surname],[e].[e_name],[e].[e_patronymics], [e].[e_gender], [e].[e_dateBirth]