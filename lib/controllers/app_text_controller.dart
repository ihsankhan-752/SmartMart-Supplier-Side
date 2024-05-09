import 'package:flutter/cupertino.dart';

class AppTextControllers extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeLocationController = TextEditingController();
  TextEditingController storeContactController = TextEditingController();
  TextEditingController storeDescriptionController = TextEditingController();

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  clear() {
    fullNameController.clear();
    emailController.clear();
    contactController.clear();
    addressController.clear();
    passwordController.clear();

    storeNameController.clear();
    storeLocationController.clear();
    storeContactController.clear();
    storeDescriptionController.clear();

    productTitleController.clear();
    productQuantityController.clear();
    productPriceController.clear();
    productDiscountController.clear();
    productDescriptionController.clear();

    notifyListeners();
  }
}
