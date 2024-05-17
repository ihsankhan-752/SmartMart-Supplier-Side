import 'package:smart_mart_supplier_side/screens/custom_navbar/chat/customer_list.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/settings/setting_screen.dart';

import '../screens/custom_navbar/dashboard/dashboard.dart';
import '../screens/custom_navbar/orders/orders.dart';
import '../screens/custom_navbar/products/products_screen.dart';

List screens = [
  Dashboard(),
  ProductsScreen(),
  OrderScreen(),
  CustomerChatListScreen(),
  SettingScreen(),
];
List tabs = [
  'Men',
  'Women',
  'Kids',
];
