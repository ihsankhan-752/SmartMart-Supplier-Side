import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

import '../controllers/loading_controller.dart';
import '../model/message_model.dart';

class ChatServices {
  Future<void> sendMessages({
    required BuildContext context,
    required String msg,
    required String docId,
    required String otherUserId,
  }) async {
    if (msg.isEmpty) {
      showCustomMessage(context, "Write Something");
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);

        DocumentSnapshot seller =
            await FirebaseFirestore.instance.collection("sellers").doc(FirebaseAuth.instance.currentUser!.uid).get();

        if ((await FirebaseFirestore.instance.collection('chat').doc(docId).get()).exists) {
          FirebaseFirestore.instance.collection("chat").doc(docId).update({
            "msg": msg,
            'createdAt': DateTime.now(),
          });
        } else {
          FirebaseFirestore.instance.collection("chat").doc(docId).set({
            'createdAt': DateTime.now(),
            "msg": msg,
            "ids": [otherUserId, FirebaseAuth.instance.currentUser!.uid],
          });
        }

        MessageModel messageModel = MessageModel(
          docId: docId,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          senderName: seller['sellerName'],
          msg: msg,
          createdAt: DateTime.now(),
          senderImage: seller['image'],
        );

        await FirebaseFirestore.instance.collection('chat').doc(docId).collection('messages').add(messageModel.toMap());

        Provider.of<LoadingController>(context, listen: false).setLoading(false);
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMessage(context, e.message!);
      }
    }
  }
}
