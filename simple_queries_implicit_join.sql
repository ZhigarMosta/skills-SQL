IF DB_ID(N'db') IS NULL BEGIN
	CREATE DATABASE [db]
END ELSE BEGIN
	PRINT N'База данных db уже существует'
END

USE db

IF OBJECT_ID(N'Student') IS NULL BEGIN
	CREATE TABLE Student(
		[id_student] INT NOT NULL,
		[s_surname] NVARCHAR(50) NOT NULL,
		[s_name] NVARCHAR(50) NOT NULL,
		[s_patronymic] NVARCHAR(50),
		[s_age] INT NOT NULL,
		[s_gender] NVARCHAR(1),
		[s_specialization_id] INT

		CONSTRAINT [PK_id_student] PRIMARY KEY([id_student])

	)
END ELSE BEGIN
	PRINT N'Таблица Student уже существует'
END

IF OBJECT_ID(N'Specialization') IS NULL BEGIN
	CREATE TABLE Specialization(
		[id_specialization] INT NOT NULL,
		[sp_namber] INT NOT NULL,
		[sp_name] NVARCHAR(50) NOT NULL,
		[sp_lvl] NVARCHAR(50),
		[sp_type] NVARCHAR(50) NOT NULL,
		[sp_prise] MONEY NOT NULL

		CONSTRAINT [PK_id_specialization] PRIMARY KEY([id_specialization])

	)
END ELSE BEGIN
	PRINT N'Таблица Specialization уже существует'
END

IF OBJECT_ID(N'Tuition_fees') IS NULL BEGIN
	CREATE TABLE Tuition_fees(
		[t_student_id] INT NOT NULL,
		[t_specialization_id] INT NOT NULL,
		[t_payment_date] DATE NOT NULL,
		[t_payment_sum] MONEY NOT NULL,
		[t_amount_debt] MONEY NOT NULL

	)
END ELSE BEGIN
	PRINT N'Таблица Tuition fees уже существует'
END

ALTER TABLE [Student]
ADD CONSTRAINT [Student_FK_student_id] FOREIGN KEY ([s_specialization_id])
	REFERENCES [Specialization] ([id_specialization])
	ON UPDATE CASCADE,
	CONSTRAINT [Student_age] CHECK ([s_age] >= 0),
	CONSTRAINT [Student_gender] CHECK ([s_gender] IN (N'М',N'Ж'))

ALTER TABLE [Specialization]
ADD CONSTRAINT [Specialization_type] CHECK ([sp_type] IN (N'бюджет',N'контракт')),
	CONSTRAINT [Specialization_prise] CHECK ([sp_prise] >= 0)

ALTER TABLE [Tuition_fees]
ADD CONSTRAINT [PK_tuition_fees] PRIMARY KEY([t_student_id], [t_specialization_id]),
       CONSTRAINT [FK_tuition_fees_id_student] FOREIGN KEY([t_student_id])
            REFERENCES [Student](id_student)
            ON UPDATE CASCADE,
        CONSTRAINT [FK_tuition_fees_id_speciality] FOREIGN KEY([t_specialization_id])
            REFERENCES [Specialization](id_specialization)
            ON DELETE NO ACTION
			ON UPDATE NO ACTION,
		CONSTRAINT [Tuition_fees_debt] CHECK (t_amount_debt >= 0),
		CONSTRAINT [Tuition_fees_sum] CHECK (t_payment_sum >= 0)

INSERT
	[Specialization]
VALUES
	(1,112,N'Программирование',N'бакалавриат',N'бюджет',100000),
	(2,145,N'Дизайн',N'магистратура',N'контракт',150000),
	(3,411,N'Политология',N'бакалавриат',N'бюджет',120000),
	(4,141,N'История',N'бакалавриат',N'бюджет',90000),
	(5,641,N'Приклодная иформатика',N'специалитет',N'контракт',180000)

INSERT
	[Student]
VALUES
	(1,N'Жигарь',N'Кирилл',N'Евгеньевич',21,N'М',5),
	(2,N'Пригодин',N'Владимир',N'Артурович',18,N'М',5),
	(3,N'Бадюлин',N'Владислав',N'Максимович',19,N'М',5),
	(4,N'Соков',N'Артур',N'Маратович',25,N'М',5),
	(5,N'Зайцев ',N'Овидий ',N'Дмитриевич',24,N'М',5),
	(6,N'Николаев ',N'Тарас ',N'Викторович',30,N'М',5),
	(7,N'Мельников ',N'Кондрат ',N'Авдеевич',55,N'М',1),
	(8,N'Зимин ',N'Нелли ',N'Аркадьевич',16,N'М',1),
	(9,N'Голубев ',N'Людвиг ',N'Степанович',17,N'М',1),
	(10,N'Еишин ',N'Адриан ',N'Валерьевич',20,N'М',1),
	(11,N'Сысоев ',N'Болеслав ',N'Михаилович',21,N'М',2),
	(12,N'Петухов ',N'Корнелий ',N'Мэлорович',22,N'М',3),
	(13,N'Вишняков ',N'Адольф ',N'Артёмович',46,N'М',4),
	(14,N'Иванов ',N'Иван',N'Иванович',12,N'М',4)


INSERT
	[Tuition_fees]
VALUES
	(1,5,N'2023-02-25',39400,0),
	(2,5,N'2023-03-25',5950,0),
	(3,5,N'2023-04-25',90554,15000),
	(4,5,N'2023-06-25',104840,123),
	(5,5,N'2023-07-25',480444,0),
	(6,5,N'2023-06-25',100000,1203),
	(7,1,N'2023-06-25',205624,0),
	(8,1,N'2023-06-25',10231,1230),
	(9,1,N'2023-06-25',1000,1523),
	(10,1,N'2023-06-25',150000,1283),
	(11,2,N'2023-06-25',15000,1823),
	(14,4,N'2023-06-25',150000,5000)


drop table [Tuition_fees]
drop table [Student]
drop table [Specialization]
--1
SELECT	[id_student] as [Индификатор студентов старше 20 лет],
		[s_age] as [Возраст],
		[s_surname] as [Фамилия],
		[s_name] as [Имя],
		[s_patronymic] as [Отество]
FROM	[Student]
WHERE	[s_age] > 20

--2
SELECT	 [id_student] as [Индификатор студентов старше 20 лет],
		[s_age] as [Возраст],
		[s_surname] as [Фамилия],
		[s_name] as [Имя],
		[s_patronymic] as [Отество]
FROM	[Student]
WHERE	[s_age] < 25 AND [s_age] > 10

--3
SELECT	[s].[sp_type] as [тип специальности],
		[s].[sp_name] as [Наименование специальности]
FROM	[Specialization] as [s]
WHERE	[s].[sp_type] like N'бюджет'

--4
SELECT	[s].[sp_namber] as [номер специальности],
		[s].[sp_name] as [Наименование специальности]
FROM	[Specialization] as [s]
ORDER BY [s].[sp_name] ASC

--5
SELECT
		[s_surname] as [Фамилия],
		[s_name] as [Имя],
		[s_patronymic] as [Отество]
FROM	[Student]
WHERE	[s_surname] like N'Е%'

--6
SELECT	[s].[s_surname] as [Фамилия],
		[s].[s_name] as [Имя],
		[s].[s_patronymic] as [Отество],
		[sp].[sp_name], [s].[s_age] as [Возраст]
FROM	[Specialization] as [sp],
		[Student] as [s]
WHERE	[sp].[sp_name] = N'Приклодная иформатика' AND [s].[s_age] >= 20 and [s].[s_age] <= 25

--7
SELECT	AVG([s].[sp_prise]) as [Средная стоимость обучения по специальностям на контракте]
FROM	[Specialization] as [s]
WHERE	[s].[sp_type] like N'контракт'

--8
SELECT	[s].[s_surname] as [Фамилия],
		[s].[s_name] as [Имя],
		[s].[s_patronymic] as [Отество],
		[sp].[sp_name] as [название специальности]
FROM	[Specialization] as [sp],
		[Student] as [s]
WHERE	[s].[s_specialization_id] = [sp].[id_specialization]
ORDER BY	[sp].[sp_name] ASC, [s].[s_surname],
			[s].[s_name] ASC,
			[s].[s_patronymic] ASC

--9
SELECT	MAX([t].[t_payment_sum]) as [Максимальная сумма платежа],
		MIN([t].[t_payment_sum]) as [Минимальная сумма платежа]
FROM	[Tuition_fees] as [t]

--10
SELECT COUNT(*) as [Количество учеников]
FROM [Student]

--11
SELECT	[sp].[sp_lvl] as [Уравни обучения],
		COUNT([sp].[sp_lvl]) as [Количество учащихся на уровне]
FROM	[Specialization] as [sp],
		[Student] as [s]
WHERE	[s].[s_specialization_id] = [sp].[id_specialization]
GROUP BY [sp].[sp_lvl]

--12
SELECT *
INTO [student_copy]
FROM [Student]

--13
SELECT TOP(1)	[s].[s_surname] as [Фамилия],
				[s].[s_name] as [Имя],
				[s].[s_patronymic] [Отчество],
				[sp].[sp_name] as [Специальность]
FROM			[Specialization] as [sp],
				[Tuition_fees] as [t],
				[Student] as [s]
WHERE			[s].[id_student] = [t].[t_student_id] AND [sp].[id_specialization] = [s].[s_specialization_id]
ORDER BY		[t].[t_payment_date] ASC

--14
SELECT  COUNT([s].[id_student]) as [Общее количество студентов],
		SUM([t].[t_amount_debt]) as [Общий долг]
FROM	[Tuition_fees] as [t], [Student] as [s]
WHERE	[t].[t_student_id] = [s].[id_student]

--15
SELECT	COUNT([t].[t_student_id]) as [Количество платежей],
		SUM([t].[t_payment_sum]) as [Сумма платежей]
FROM	[Student] as [s],
		[Tuition_fees] as [t]
WHERE [t].[t_student_id] = [s].[id_student] AND [s].[s_name] = N'Иван' AND [s].[s_surname] = N'Иванов' AND [s].[s_patronymic] = N'Иванович'

--16
SELECT   [s].[s_surname] + ' ' + [s].[s_name] + ' ' + [s].[s_patronymic] as [Полное имя студента],		--по id специальности
         SUM([t].[t_payment_sum]) as [Общая сумма за оплату обучения], 
	     SUM([t].[t_amount_debt]) as [Общая сумма долга]
FROM	 [Student] as [s],
		 [Tuition_fees] as [t]
WHERE	 [s].[id_student] = [t].[t_student_id] AND [t].[t_specialization_id] = 5
GROUP BY [s].[s_surname], [s].[s_name], [s].[s_patronymic]
HAVING SUM([t].[t_amount_debt]) = 0 AND SUM([t].[t_payment_sum]) >= 200000


SELECT   [s].[s_surname] + ' ' + [s].[s_name] + ' ' + [s].[s_patronymic] as [Полное имя студента],			--по названию специальности
         SUM([t].[t_payment_sum]) as [Общая сумма за оплату обучения], 
	     SUM([t].[t_amount_debt]) as [Общая сумма долга], [sp].[sp_name]
FROM	 [Student] as [s],
		 [Tuition_fees] as [t],
		 [Specialization] as [sp]
WHERE	 [s].[id_student] = [t].[t_student_id] AND [sp].[id_specialization] = [t].[t_specialization_id] AND [sp].[sp_name] like N'Приклодная иформатика'
GROUP BY [s].[s_surname], [s].[s_name], [s].[s_patronymic],[sp].[sp_name]
HAVING SUM([t].[t_amount_debt]) = 0 AND SUM([t].[t_payment_sum]) >= 200000

--17
SELECT	[sp].[sp_name] as [Наименование специальности],
		COUNT([s].[id_student]) as [Количество студентов]
FROM	[Specialization] as [sp],
		[Student] as [s]
WHERE	[sp].[id_specialization] = [s].[s_specialization_id]
GROUP BY [sp].[sp_name]
HAVING COUNT([s].[id_student]) > 4

--18
SELECT	[sp].[sp_name] as [Наименование специальности],
		COUNT([s].[id_student]) as [Количество студентов]
FROM	[Specialization] as [sp],
		[Student] as [s]
WHERE [sp].[id_specialization] = [s].[s_specialization_id]
GROUP BY [sp].[sp_name]
ORDER BY [Количество студентов] DESC

--19
SELECT	[s].[s_name] as [Имя], SUM([t].[t_amount_debt]) as [Сумма долга]
FROM	[Tuition_fees] as [t],
		[Student] as [s]
WHERE	[s].[id_student] = [t].[t_student_id]
GROUP BY [s].[s_name],[t].[t_amount_debt]
HAVING SUM([t].[t_amount_debt]) < (SELECT AVG([t_amount_debt]) FROM [Tuition_fees])

--20
SELECT	DATENAME(MONTH, [t].[t_payment_date]) as [Месяца],
		COUNT(*) as [Количество платежей],
		SUM([t_payment_sum]) as [Общая сумма платежа]
FROM	[Tuition_fees] as [t]
WHERE	YEAR([t].[t_payment_date]) = 2023
GROUP BY DATENAME(MONTH, [t].[t_payment_date])

--21
SELECT	[sp].[sp_name] as [Название специальности],
		COUNT(*) as [Количество студетов специальности],
		ROUND(CAST(COUNT(*) as REAL) / (SELECT COUNT(*) FROM [Student]) * 100, 2) as [%]
FROM [Specialization] as [sp], [Student] as [s]
WHERE [s].[s_specialization_id] = [sp].[id_specialization]
GROUP BY [sp].[sp_name]
ORDER BY [%] ASC
