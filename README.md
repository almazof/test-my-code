# test for iOS developer
Разработайте экран, где человек может заполнить информацию о себе и своих детях.
Сверху должны быть поля ввода ФИО и возраста пользователя.
Ниже должна вводится информация о детях. Изначально пользователь видит только кнопку "+", при нажатии на нее появляется блок в котором можно ввести информацию о ребенке: Имя и возраст. Таким образом пользователь может добавить вплоть до 5 детей. Когда пользователь добавил 5 детей — кнопка "+" исчезает и больше недоступна. Так же напротив каждого ребенка есть кнопка "удалить", при нажатии на которую соответствующая запись удаляется.


# test for iOS developer 2

Практика: Написать iOS приложение в котором нужно отрисовать tableView и заполнить ее данными (сделать Продукты (овощи, фруктами, мясо, вода и тд) По нажатию на ячейку открыть след экран в котором отобразить все виды продуктов, реализовать пагинацию для прогрузки след продуктов. Сделать рефреш экрана по свайпу вниз. По нажатию на продукт открыть детальный экран в котором будет картинка продукта и отобразить ниже свойства продукта. Так же реализовать локальное удаление продуктов на экране с всеми продуктами. Так же реализовать поиск по категориям продуктов.
Требования:
Swift, верстка по желанию (кодом или storyboard), подключение Api (будет плюсом нативно) так же можно с помощью cocapods библиотек.
API:
curl --location --request GET 'http://62.109.7.98/api/product/12' \ --header 'Accept: application/json'
curl --location --request GET 'http://62.109.7.98/api/product/category/1' \ --header 'Accept: application/json'
curl --location --request GET 'http://62.109.7.98/api/categories' \ --header 'Accept: application/json'

P.S.: Так как в api нет картинок, взял 5 картинов в интернете и рандомно их показал

