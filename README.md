# Вступительная лабораторная работа
Лабораторная работа выполнена на ветке Solution.
```linux
git clone -b Solution git@github.com:TFS-iOS/intro-lab-mightyK1ngRichard.git
```

<img class="screen_application" src="https://github.com/TFS-iOS/intro-lab-mightyK1ngRichard/blob/Solution/Screen/preview.png" width="1000">


## Задача

В этой лабораторной работе вам предлагается создать приложение, которое будет, используя API, загружать заголовки новостей и показывать их в виде списка. По тапу на новость из списка переходить к просмотру полной информации по выбранной новости.

## Источник данных

В качестве источника данных можно использовать <https://newsapi.org/>

## Основные требования

- [X] **Приложение должно быть написано на Swift. Без использования SwiftUI. Без использования сторонних библиотек/подов.**
- [X] Для UI можно использовать XIB и верстку кодом, не рекомендуется использовать Storyboard.
- [X] Минимальная поддерживаемая версия приложения - iOS 14.
- [X] Загружать не больше 20-ти новостей одномоментно.
- [X] Предусмотреть возможность обновления списка новостей.
- [X] На каждой ячейке должны отображаться:
  * заголовок,
  * картинка,
  * количество просмотров содержимого (переходов на экран деталей новости).
- [X] При нажатии на каждую новость должен открываться новый экран и показывать ее краткое содержимое:
  * заголовок,
  * картинку,
  * описание,
  * дату публикации,
  * источник публикации,
  * кликабельную ссылку на полный текст новости.
- [X] Полный текст новости должен открываться с использованием WebKit.
- [X] Данные о новостях (заголовок, краткое содержание, ссылка на полную версию и тд.) и счетчик просмотров необходимо кэшировать каким-либо образом.
- [X] Закэшированные данные отображаются перед отправлением запроса на обновление данных.
- [X] Закэшированные данные доступны и после перезапуска приложения.

## Что можно улучшить

* Постраничная загрузка всех доступных новостей бесконечной лентой (пагинация по 20 новостей).
- [X] Обновлять список новостей с помощью жеста pull-to-refresh.
* Обработка исключений. Например, отсутствие интернет-соединения.

Выполнение данных пунктов увеличивает ваши шансы на поступление в школу. По статистике зачисленные на курс студенты выполняли все или несколько из описанных улучшений.

## Чеклист перед сдачей работы

* [X] Проверить соответствие работы требованиям в задании
* [X] Хотя бы попробовать сделать дополнительные пункты из задания
* [X] Убедиться, что все файлы закоммичены
* [X] Запушить коммиты на GitHub — проверить, что они отображаются на сайте
* [X] Повторно клонировать репозиторий в отдельную папку и собрать проект из нее — убедиться, что все запускается и работает как надо
* [X] Отправить ссылку на репозиторий через учебный портал
