import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/model/store_model.dart';
import 'package:smart_mart_supplier_side/services/store_services.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../controllers/seller_controller.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/text_input.dart';
import '../../widgets/custom_appbar_header.dart';
import '../my_profile/widgets/title_value_widget.dart';

class MyStoreScreen extends StatefulWidget {
  const MyStoreScreen({super.key});

  @override
  State<MyStoreScreen> createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  StoreModel _storeModel = StoreModel();
  @override
  Widget build(BuildContext context) {
    final sellerController = Provider.of<SellerController>(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarHeader(
            title: "My Store",
            widget: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
            suffixWidget: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ShowEditProfileWidgetForStore(storeModel: _storeModel);
                    });
              },
              child: Text("Edit Store", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('stores')
                  .where('sellerId', isEqualTo: sellerController.sellerModel.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Store Found",
                      style: AppTextStyles.DASHBOARD_MENU_STYLE.copyWith(fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    _storeModel = StoreModel.fromMap(snapshot.data!.docs[index]);
                    return Column(
                      children: [
                        Center(
                          child: _storeModel.storeLogo == ""
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Image.asset(AppAssets.products, color: AppColors.primaryWhite),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(_storeModel.storeLogo!),
                                ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleValueWidget(title: "Store Name", value: _storeModel.storeName),
                                TitleValueWidget(title: "Address", value: _storeModel.address!),
                                TitleValueWidget(title: "Contact", value: _storeModel.contact!.toString()),
                                TitleValueWidget(title: "Description", value: _storeModel.description!),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ShowEditProfileWidgetForStore extends StatefulWidget {
  final StoreModel storeModel;
  const ShowEditProfileWidgetForStore({super.key, required this.storeModel});

  @override
  State<ShowEditProfileWidgetForStore> createState() => _ShowEditProfileWidgetForStoreState();
}

class _ShowEditProfileWidgetForStoreState extends State<ShowEditProfileWidgetForStore> {
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Edit Profile",
                        style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Store Name"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.storeModel.storeName, controller: _storeNameController),
                    SizedBox(height: 10),
                    Text("Contact"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.storeModel.contact.toString(), controller: _phoneController),
                    SizedBox(height: 10),
                    Text("Store Address"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.storeModel.address, controller: _addressController),
                    SizedBox(height: 10),
                    Text("Description"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.storeModel.description, controller: _descriptionController),
                    SizedBox(height: 30),
                    Consumer<LoadingController>(builder: (context, loadingController, child) {
                      return loadingController.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PrimaryButton(
                              onPressed: () {
                                StoreServices().updateStoreInformation(
                                    storeId: widget.storeModel.storeId!,
                                    context: context,
                                    storeName: _storeNameController.text.isEmpty
                                        ? widget.storeModel.storeName!
                                        : _storeNameController.text,
                                    contact: _phoneController.text.isEmpty
                                        ? widget.storeModel.contact!
                                        : int.tryParse(_phoneController.text)!,
                                    address:
                                        _addressController.text.isEmpty ? widget.storeModel.address! : _addressController.text,
                                    description: _descriptionController.text.isEmpty
                                        ? widget.storeModel.description!
                                        : _descriptionController.text);
                              },
                              title: "Update",
                              btnColor: AppColors.primaryColor,
                            );
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
