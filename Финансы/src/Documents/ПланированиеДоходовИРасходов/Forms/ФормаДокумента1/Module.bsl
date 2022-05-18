&НаСервереБезКонтекста
Функция МесяцСтрокой(НачальнаяДата, КолвоМесяцев)
	
	Возврат Формат(ДобавитьМесяц(НачалоМесяца(НачальнаяДата), КолвоМесяцев - 1), "ДФ='MMMM yyyy'");
	
КонецФункции

&НаКлиенте
Процедура УправлениеВидимостью()
	
	Для НомерМесяца = 1 По 12 Цикл
		СтрокаНомерМесяца = Формат(НомерМесяца, "ЧЦ=2; ЧДЦ=0; ЧВН=");
		Элементы["ПланированиеСумма"+СтрокаНомерМесяца].Видимость = Объект["Месяц"+СтрокаНомерМесяца];
		Элементы["ПланированиеСумма"+СтрокаНомерМесяца].Заголовок = МесяцСтрокой(Объект.НачальнаяДатаПланирования, НомерМесяца);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура НачальнаяДатаПланированияПриИзменении(Элемент)
	Объект.НачальнаяДатаПланирования = НачалоМесяца(Объект.НачальнаяДатаПланирования);
КонецПроцедуры

&НаКлиенте
Процедура НачальнаяДатаПланированияРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	Объект.НачальнаяДатаПланирования = ДобавитьМесяц(Объект.НачальнаяДатаПланирования, Направление);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииФлагаМесяца(Элемент)
	
	НомерИзменяемогоСтолбца = Число(Прав(Элемент.Имя,2));
	
	Для НомерМесяца = 1 По НомерИзменяемогоСтолбца Цикл
		Объект["Месяц"+Формат(НомерМесяца, "ЧЦ=2; ЧДЦ=0; ЧВН=")] = Истина;
	КонецЦикла;
	
	Для НомерМесяца = НомерИзменяемогоСтолбца + 1 По 12 Цикл
		Объект["Месяц"+Формат(НомерМесяца, "ЧЦ=2; ЧДЦ=0; ЧВН=")] = Ложь;
	КонецЦикла;
	
	УправлениеВидимостью();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УправлениеВидимостью();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСтатьи(Команда)
	
	Если Объект.Планирование.Количество() <> 0 Тогда
		
		Если Вопрос("В документе уже есть данные для планирования. Все равно очистить документ?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет Тогда
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	ЗаполнитьСтатьиНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтатьиНаСервере()
	
	Объект.Планирование.Очистить();
	 
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДвиженияДенежныхСредствОбороты.СтатьяДоходовРасходов.Родитель КАК СтатьяДоходовРасходовРодитель,
		|	СУММА(ДвиженияДенежныхСредствОбороты.СуммаРасходаОборот) КАК СуммаРасходаОборот
		|ИЗ
		|	РегистрНакопления.ДвиженияДенежныхСредств.Обороты(&Дата1, &Дата2, , ВалютаДвижения = &Рубль) КАК ДвиженияДенежныхСредствОбороты
		|
		|СГРУППИРОВАТЬ ПО
		|	ДвиженияДенежныхСредствОбороты.СтатьяДоходовРасходов.Родитель
		|
		|УПОРЯДОЧИТЬ ПО
		|	СтатьяДоходовРасходовРодитель
		|АВТОУПОРЯДОЧИВАНИЕ";

	Запрос.УстановитьПараметр("Дата1", ДобавитьМесяц(НачалоМесяца(ТекущаяДата()), -3));
	Запрос.УстановитьПараметр("Дата2", НачалоМесяца(ТекущаяДата()) - 1);
	Запрос.УстановитьПараметр("Рубль", Константы.ОсновнаяВалютаУчета.Получить());

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		НС = Объект.Планирование.Добавить();
		НС.СтатьяДоходовИРасходов = ВыборкаДетальныеЗаписи.СтатьяДоходовРасходовРодитель;
		
		Для НомерМесяца = 1 По 12 Цикл
			СтрокаНомерМесяца = Формат(НомерМесяца, "ЧЦ=2; ЧДЦ=0; ЧВН=");
			Если Объект["Месяц"+СтрокаНомерМесяца] Тогда
				НС["Сумма"+СтрокаНомерМесяца] = ВыборкаДетальныеЗаписи.СуммаРасходаОборот;
			Иначе
				НС["Сумма"+СтрокаНомерМесяца] = 0;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры
