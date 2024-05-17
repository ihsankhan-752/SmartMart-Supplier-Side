import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_mart_supplier_side/model/notification_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_appbar_header.dart';

import '../../../../constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarHeader(
            title: "Notifications",
            widget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notifications')
                  .where('toUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Notification Found",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mirador',
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    NotificationModel notificationModel = NotificationModel.fromMap(snapshot.data!.docs[index]);
                    return Text(notificationModel.title!);
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
