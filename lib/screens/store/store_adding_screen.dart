import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/controllers/app_text_controller.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/services/store_services.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';
import 'package:smart_mart_supplier_side/widgets/text_input.dart';

class StoreAddingScreen extends StatefulWidget {
  const StoreAddingScreen({super.key});

  @override
  State<StoreAddingScreen> createState() => _StoreAddingScreenState();
}

class _StoreAddingScreenState extends State<StoreAddingScreen> {
  AppTextControllers appTextControllers = AppTextControllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: Text(
          "Add Store Information",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Store Name", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
              SizedBox(height: 7),
              AuthTextInput(
                controller: appTextControllers.storeNameController,
                hintText: "store1",
              ),
              SizedBox(height: 20),
              Text("Location", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
              SizedBox(height: 7),
              AuthTextInput(
                controller: appTextControllers.storeLocationController,
                hintText: "Swat kpk",
              ),
              SizedBox(height: 20),
              Text("Contact", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
              SizedBox(height: 7),
              AuthTextInput(
                controller: appTextControllers.storeContactController,
                hintText: "0946-121212",
                inputType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text("Description", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
              SizedBox(height: 7),
              AuthTextInput(
                controller: appTextControllers.storeDescriptionController,
                hintText: "Fluxstore is one of the finest shopping center...",
                maxLines: 5,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: Consumer<LoadingController>(builder: (context, loadingController, child) {
          return loadingController.isLoading
              ? Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : PrimaryButton(
                  onPressed: () {
                    StoreServices.addStore(
                      context: context,
                      storeName: appTextControllers.storeNameController.text,
                      storeLocation: appTextControllers.storeLocationController.text,
                      contact: int.tryParse(appTextControllers.storeContactController.text),
                      description: appTextControllers.storeDescriptionController.text,
                    );
                  },
                  btnColor: AppColors.primaryColor,
                  title: "Create Account",
                );
        }),
      ),
    );
  }
}
