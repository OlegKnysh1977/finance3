Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Если ЭтоГруппа Тогда
	
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	СтатьиДоходовИРасходов.Ссылка
			|ИЗ
			|	Справочник.СтатьиДоходовИРасходов КАК СтатьиДоходовИРасходов
			|ГДЕ
			|	СтатьиДоходовИРасходов.Родитель = &Ссылка
			|
			|ДЛЯ ИЗМЕНЕНИЯ
			|	Справочник.СтатьиДоходовИРасходов";

		Запрос.УстановитьПараметр("Ссылка", Ссылка);

		Результат = Запрос.Выполнить();

		ВыборкаДетальныеЗаписи = Результат.Выбрать();

		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
			ЭлементОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
			ЭлементОбъект.ТипСтатьиДоходовРасходов = ТипСтатьиДоходовРасходов;
			ЭлементОбъект.Записать();
			
		КонецЦикла;
	
	КонецЕсли;
	
КонецПроцедуры
