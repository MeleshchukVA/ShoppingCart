# Shopping Cart
## Финальный проект по курсу "iOS Developer" от Газпромбанка и онлайн-школы OTUS

## Требования к проекту
- ✅ Проект реализован с использованием нативных средств Apple без добавления сторонних библиотек. 
Подключаем через CocoaPods. Исключение составляют:
  - SwiftLint
  - Опционально для тестов: Sourcery, Cuckoo, Quick/Nimble
  - Опционально для сети: Moya
- ✅ Верстка UI осуществляется без использования storyboard/xib (использование anchors и frame)
- ✅ Проект должен поддерживать сохранение данных с использованием Core Data
- ✅ Проект поддерживает работу с данными через сеть
- ✅ При загрузке и отрисовке данных используются анимации
- ✅ Архитектура проекта: VIPER
- ✅ Минимум 5 экранов
- ✅ Обязательное покрытие проекта Unit-тестами (минимум 3 VIPER-сцены и связанные сервисы)
- ✅ Минимальная поддерживаемая версия: iOS 12
- ❔Опциональное требование: использовать шиммеры на 1-ом экране

## Краткое описание
Приложение загружает каталог товаров из сети с возможностью добавить их в корзину и оформить заказ. Если перезапустить приложение, данные в корзине сохраняются и можно продолжить оформлять заказ.

## Установка
Для запуска приложения необходимо установить [SwiftLint](https://github.com/realm/SwiftLint) через [CocoaPods](https://cocoapods.org/).

## Стек
- Архитектура: VIPER
- Минимальная поддерживаемая версия: iOS 12
- Верстка приложения: программно
- Работа с сетью: URLSession, POST- и GET-запросы
- Сохранение данных: 
  - Core Data для корзины товаров
  - UserDefaults для онбординга
- Тесты: XCTest
- Паттерны проектирования:
  - Coordinator для навигации
  - Dependency Injection для сервисов работы с сетью и данными
  - Singleton для сервиса конвертера валют и сервиса кеширования картинок
  - Adapter для работы с UITableView и UICollectionView

## Подробное описание

### Экраны

Приложение состоит из 5 экранов, написанных на VIPER + 1 экран для онбординга. Каждый экран представляет из себя отдельный модуль.

- <details><summary>Onboarding</summary>

  Экран модуля Onboarding представляет из себя UIPageViewController с 4-мя экранами и анимированной кнопкой "Skip and Go". Экран появляется при первом запуске приложения. При повторном запуске приложения онбординг не показывается. Данные о нем хранятся в UserDefaults  

  https://user-images.githubusercontent.com/45876618/207903960-640c2e94-0eef-4c2b-8c75-64e5c4c9c47c.mp4

  </details>


- <details><summary>Catalogue</summary>

  Экран модуля Catalogue представляет из себя:
    - UITableView, который отображает категории товаров. Данные о категориях берутся из сети
    - UISearchController для поиска товаров. При успешном поиске отображается UICollectionView с товарами из модуля Product. При неуспешном поиске на экране отображается соответствующая надпись. Поиск также осуществляется с помощью запроса в сеть

  https://user-images.githubusercontent.com/45876618/207381140-241ee307-c26f-440e-bbe9-ed3571e22e14.mp4

  </details>


- <details><summary>Product</summary>

  Экран модуля Product отображается при выборе категории из модуля Catalogue. Экран представляет из себя UICollectionView. Данные о товаре берутся из сети. Если товары в категории отсутствуют, отображается соответствующая надпись. При нажатии на кнопку корзины:
    - Данные о товаре сохраняются в Core Data и отображаются на экране модуля Cart
    - Увеличивается счетчик товаров в UITabBarController

  https://user-images.githubusercontent.com/45876618/207384752-11a46299-b79e-499f-9204-a772abd671e0.mp4

  </details>


- <details><summary>Cart</summary>

  Экран модуля Cart представляет из себя:
    - UITableView с данными о товаре. В корзине можно увеличить или уменьшить число товаров, после чего отобразится соответствующая цена. Данные в корзине сохраняются в Core Data и доступны после перезапуска приложения. Можно удалить товары и поделиться ими через UIAlertViewController
    - Кнопку Checkout, при нажатии на которую вызывается модуль Checkout

  https://user-images.githubusercontent.com/45876618/207385041-5d090e01-8673-482a-91e0-a8a2a515bbe8.mp4

  </details>


- <details><summary>Checkout</summary>

  Экран модуля Checkout представляет из себя ModalView, которое можно свайпнуть вниз. Экран состоит из:
    - UITableView, который отображает список товаров, цену и их количество. Данные берутся из сети
    - Кнопку Buy. Если интернет доступен, то отобразится UIAlertViewController с надписью Success. При нажатии на кнопку "OK" экран модуля закрывается и данные из корзины удаляются

  https://user-images.githubusercontent.com/45876618/207385766-d5d18c3b-124c-481a-8b05-8038fde54f00.mp4

  </details>


- <details><summary>Profile</summary>

  Экран модуля Profile представляет из себя  экран, на котором отображается информация о пользователе. Данные для экрана берутся из сети

  https://user-images.githubusercontent.com/45876618/207386003-b1319f07-3100-4efb-8dfc-1951dd68c1e6.mp4

  </details>
  

### Анимации

- Анимирована загрузки данных с помощью UIActivityIndicator как на экранах приложения, так и на картинках товаров
- Анимированы кнопки добавления в корзину
- Анимированы ячейки с товарами при нажатии на них

  <img src="https://user-images.githubusercontent.com/45876618/207906247-5fcad01d-6751-4046-862b-065479da7a51.gif" width="20%" height="20%"> <img src="https://user-images.githubusercontent.com/45876618/207895752-0f66f024-13e4-49a3-a664-896dc46aab3b.gif" width="20%" height="20%"> <img src="https://user-images.githubusercontent.com/45876618/207895703-f864cbf7-cc6c-4aff-9302-edbbb099c7da.gif" width="20%" height="20%"> 

### Обработка исключений

- Отсутствие сети на главном экране
- Отсутствие сети при заказе товара
- Отсутствие товаров по заданному слову в поиске
- Отсутствие товаров в категории

  <img src="https://user-images.githubusercontent.com/45876618/207390757-27d91e38-8e19-4582-8f0f-a7c2c726680a.png" width="20%" height="20%"> <img src="https://user-images.githubusercontent.com/45876618/207390761-520ea66e-dc24-4850-a19f-ee8b656580fe.png" width="20%" height="20%"> <img src="https://user-images.githubusercontent.com/45876618/207390752-6e756f3e-151e-4ec6-88b2-a328dc5ff0eb.png" width="20%" height="20%"> <img src="https://user-images.githubusercontent.com/45876618/207390744-367f71c3-9f25-4478-858d-51de25006502.png" width="20%" height="20%">

### Поддержка версий iOS

- <details><summary>iOS 12</summary>

  https://user-images.githubusercontent.com/45876618/208123699-f1f57891-2c85-4aa9-bf34-9fdf2eb2237e.mov

  </details>
  
  
- <details><summary>iOS 13</summary>

  https://user-images.githubusercontent.com/45876618/208123735-6beaddf0-55b2-4504-843f-c0ea38a3102d.mov

  </details>
  
  
- <details><summary>iOS 14</summary>

  https://user-images.githubusercontent.com/45876618/208123759-fcf495cb-8d1d-4d0f-8a58-8ab7fd094b88.mov

  </details>
  
  
- <details><summary>iOS 15</summary>

  https://user-images.githubusercontent.com/45876618/208123785-85dcb088-8ed8-444e-8e6a-a4319fdd58fd.mov

  </details>
  
  
- <details><summary>iOS 16</summary>

  https://user-images.githubusercontent.com/45876618/208123815-3c41a9c0-6d84-400d-951c-8762aefe28c8.mov

  </details>

### Unit-тесты

- Протестированы презентеры модулей Catalogue, Cart, Product
- Протестированы сервисы для работы с сетью и Core Data

### Прочее
- API: https://dummyjson.com/
- Для кэширования картинок использован один класс из open-source библиотеки [LRUCache](https://github.com/nicklockwood/LRUCache). "Обертка" для класса написана самостоятельно

## Что можно улучшить/добавить:
- Добавить экран с подробным описанием товара, кнопкой покупки и возможностью выбора количества товара при нажатии на кнопку покупки
- Улучшить поиск по товарам
- Настроить увеличение счетчика товаров в таббаре и корзине, если нажать на кнопку корзины для одного и того же товара
- В случае, если уменьшается количество товара до 0, удалять ячейку таблицы на экране с корзиной
- Добавить swipe to deletе для товара на экране с корзиной
- Покрыть приложение большим количеством тестов.
