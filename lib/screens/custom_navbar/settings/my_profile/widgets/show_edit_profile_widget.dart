import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../controllers/loading_controller.dart';
import '../../../../../model/seller_model.dart';
import '../../../../../services/seller_profile_services.dart';
import '../../../../../widgets/buttons.dart';
import '../../../../../widgets/text_input.dart';

class ShowEditProfileWidget extends StatefulWidget {
  final SellerModel sellerModel;
  const ShowEditProfileWidget({super.key, required this.sellerModel});

  @override
  State<ShowEditProfileWidget> createState() => _ShowEditProfileWidgetState();
}

class _ShowEditProfileWidgetState extends State<ShowEditProfileWidget> {
  TextEditingController _sellerNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
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
                    Text("Name"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.sellerModel.sellerName, controller: _sellerNameController),
                    SizedBox(height: 10),
                    Text("Contact"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.sellerModel.phone.toString(), controller: _phoneController),
                    SizedBox(height: 10),
                    Text("Address"),
                    SizedBox(height: 5),
                    CustomTextInput(hintText: widget.sellerModel.address, controller: _addressController),
                    SizedBox(height: 30),
                    Consumer<LoadingController>(builder: (context, loadingController, child) {
                      return loadingController.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PrimaryButton(
                              onPressed: () {
                                SellerProfileServices().updateSellerInfo(
                                  context: context,
                                  sellerName: _sellerNameController.text.isEmpty
                                      ? widget.sellerModel.sellerName!
                                      : _sellerNameController.text,
                                  phone: _phoneController.text.isEmpty
                                      ? widget.sellerModel.phone!
                                      : int.tryParse(_phoneController.text)!,
                                  address:
                                      _addressController.text.isEmpty ? widget.sellerModel.address! : _addressController.text,
                                );
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
