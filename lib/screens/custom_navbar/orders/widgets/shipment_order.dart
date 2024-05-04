import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../services/notification_services.dart';
import '../../../../widgets/custom_msg.dart';

class ShipmentOrder extends StatelessWidget {
  const ShipmentOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("supplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("orderStatus", isEqualTo: "shipment")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Sorry No Order In Shipment!",
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 22,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderInfo = snapshot.data!.docs[index];
              return Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ...orderInfo['pdtImages'].map((e) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              height: 100,
                              width: 120,
                              child:
                                  ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(e, fit: BoxFit.cover)),
                            );
                          }).toList(),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Names",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 05),
                              ...orderInfo['pdtName'].map((e) {
                                return Text(
                                  e,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Price",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 05),
                              ...orderInfo['pdtPrice'].map((e) {
                                return Text(
                                  e.toString() + "USD",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection('orders').doc(orderInfo.id).update({
                                'orderStatus': 'deliver',
                              });
                              await NotificationServices().sendPushNotification(
                                orderInfo['customerId'],
                                'Your Order is Shipped Successfully and Will be Delivered Soon',
                                'Order Update',
                              );
                              await NotificationServices().addNotificationInDB(
                                userId: orderInfo['customerId'],
                                title: 'Your Order Is Shipped Successfully',
                              );

                              showCustomMessage(context, 'Order Prepare For Shipment');
                            },
                            child: Text("Shift Order"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
