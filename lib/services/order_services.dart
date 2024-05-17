import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/services/notification_services.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

import '../model/notification_model.dart';

class OrderServices {
  static updateOrderStatus({
    required BuildContext context,
    required String orderId,
    required String customerId,
    required String orderStatus,
    required String notificationBody,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);

      await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
        'orderStatus': orderStatus,
      });

      await NotificationServices().sendPushNotification(
        customerId,
        "Order Updates",
        "$notificationBody",
      );
      NotificationModel notificationModel = NotificationModel(
        fromUserId: FirebaseAuth.instance.currentUser!.uid,
        toUserId: customerId,
        title: "Order Updates",
        body: "Your Order Status is Update to $orderStatus",
        createdAt: DateTime.now(),
      );
      await FirebaseFirestore.instance.collection('notifications').add(notificationModel.toMap());

      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.back();
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);

      showCustomMessage(context, e.message!);
    }
  }
}
