
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДеревоСтатейДоходовИРасходов.Параметры.УстановитьЗначениеПараметра("ВариантБюджета", Объект.ВариантБюджета);
КонецПроцедуры

&НаСервере
Процедура ВариантБюджетаПриИзмененииНаСервере()
	ДеревоСтатейДоходовИРасходов.Параметры.УстановитьЗначениеПараметра("ВариантБюджета", Объект.ВариантБюджета);
КонецПроцедуры

&НаКлиенте
Процедура ВариантБюджетаПриИзменении(Элемент)
	ВариантБюджетаПриИзмененииНаСервере();
КонецПроцедуры
