import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/models/order_model.dart';
import 'package:greengrocer_course/src/models/user_model.dart';

ItemModel apple = ItemModel(
  imgUrl: 'assets/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya
];

List<CartItemModel> cartItem = [
  CartItemModel(
    item: apple, 
    quantity: 1
  ),
  CartItemModel(
    item: grape, 
    quantity: 3
  ),
  CartItemModel(
    item: mango, 
    quantity: 4
  ),
  CartItemModel(
    item: papaya, 
    quantity: 5
  ),
];

List<String> categories = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais'
];

UserModel user = UserModel(
  name: 'Sena', 
  email: 'sena@gmail.com', 
  phone: '239922903', 
  cpf: '82969232232', 
  password: '22222222'
);

List<OrderModel> orders = [
  OrderModel(
    id: 'V92dojs3q', 
    cratedDateTime: DateTime.parse('2022-08-10 10:00:10.458'), 
    overdueDateTime: DateTime.parse('2022-08-19 11:00:10.458'), 
    status: 'preparing_purchase', 
    copyAndPaste: 'asd6a54dauhew923', 
    total: 11.0,
    items: [ 
      CartItemModel(
        item: apple,
        quantity: 2
      ),
    ] 
  ),

  OrderModel(
    id: 'V92dojs3q', 
    cratedDateTime: DateTime.parse('2022-08-10 10:00:10.458'), 
    overdueDateTime: DateTime.parse('2022-08-19 11:00:10.458'), 
    status: 'pending_payment', 
    copyAndPaste: 'asd6a54dauhew923', 
    total: 11.0,
    items: [ 
      CartItemModel(
        item: apple,
        quantity: 2
      ),
    ] 
  )
];