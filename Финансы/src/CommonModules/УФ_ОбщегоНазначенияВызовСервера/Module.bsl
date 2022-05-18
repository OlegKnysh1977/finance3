#Область СлужебныеПроцедурыИФункции

// Возвращает признак работы в режиме разделения данных по областям
// (технически это признак условного разделения).
// 
// Возвращает Ложь, если конфигурация не может работать в режиме разделения данных
// (не содержит общих реквизитов, предназначенных для разделения данных).
//
// Возвращаемое значение:
//  Булево - Истина, если разделение включено.
//         - Ложь,   если разделение выключено или не поддерживается.
//
Функция РазделениеВключено() Экспорт

	Возврат ОбщегоНазначения.РазделениеВключено();
	
КонецФункции


Функция ЧекУникален(ШКЧека, ДокСсылка)
КонецФункции

#КонецОбласти
