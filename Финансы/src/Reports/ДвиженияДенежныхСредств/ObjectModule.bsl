
Процедура УстановитьПараметрКомпоновки(СтрИмяПараметраКомпоновки, ЗначениеПараметраКомпоновки, ИспользованиеПараметраКомпоновки = Истина)
	
	Параметр = КомпоновщикНастроек.Настройки.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных(СтрИмяПараметраКомпоновки));
	Параметр.Значение = ЗначениеПараметраКомпоновки;
	Параметр.Использование = ИспользованиеПараметраКомпоновки;
	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)

	УстановитьПараметрКомпоновки("НачалоПериода", НачалоДня(НачалоПериода));
	УстановитьПараметрКомпоновки("КонецПериода", КонецДня(КонецПериода));
	УстановитьПараметрКомпоновки("ОтборСчетУчета", Ложь);
	Если ЗначениеЗаполнено(СчетУчета) Тогда
		УстановитьПараметрКомпоновки("ОтборСчетУчета", Истина);
		УстановитьПараметрКомпоновки("СчетУчета", СчетУчета);
	КонецЕсли;
	УстановитьПараметрКомпоновки("ОтборВалютаДвижения", Ложь);
	Если ЗначениеЗаполнено(ВалютаДвижения) Тогда
		УстановитьПараметрКомпоновки("ОтборВалютаДвижения", Истина);
		УстановитьПараметрКомпоновки("ВалютаДвижения", ВалютаДвижения);
	КонецЕсли;
	УстановитьПараметрКомпоновки("ОтборСтатьяДоходовРасходов", Ложь);
	Если ЗначениеЗаполнено(СтатьяДоходовРасходов) Тогда
		УстановитьПараметрКомпоновки("ОтборСтатьяДоходовРасходов", Истина);
		УстановитьПараметрКомпоновки("СтатьяДоходовРасходов", СтатьяДоходовРасходов);
	КонецЕсли;
	
	ЗаголовокОтчета = КомпоновщикНастроек.Настройки.ПараметрыВывода.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Заголовок"));
	ЗаголовокОтчета.Значение = "Движения денежных средств за период с " + Формат(НачалоПериода, "ДФ=dd.MM.yyyy") + " по " + Формат(КонецПериода, "ДФ=dd.MM.yyyy");
	
	// Сформируем отчет
	
	Настройки = КомпоновщикНастроек.Настройки;
	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	// Инициализируем процессор СКД
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки);
	
	ДокументРезультат.Очистить();
	
	// Инициализируем процессор вывода
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры
