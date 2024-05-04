import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/services/notification_services.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import 'order_info_card.dart';

class PreparingOrder extends StatelessWidget {
  const PreparingOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("supplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("orderStatus", isEqualTo: "preparing")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Sorry No Order Found!",
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 22,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          //todo fetching list of data from db
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total : ${orderInfo['orderPrice']}",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
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
                                'orderStatus': 'shipment',
                              });

                              await NotificationServices().sendPushNotification(
                                orderInfo['customerId'],
                                'Your Order is Received an Prepare for shipment',
                                'Order Update',
                              );

                              await NotificationServices().addNotificationInDB(
                                  userId: orderInfo['customerId'], title: 'Your Order Is Ready for Shipment');

                              showCustomMessage(context, 'Order Prepare For Shipment');
                            },
                            child: Text("Shift Order"),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection('orders').doc(orderInfo.id).update({
                                  'orderStatus': 'cancel',
                                });

                                await NotificationServices().sendPushNotification(
                                  orderInfo['customerId'],
                                  'Your Order is Cancelled ',
                                  'Order Update',
                                );
                                await NotificationServices().addNotificationInDB(
                                  userId: orderInfo['customerId'],
                                  title: 'Your Order Is Cancel',
                                );
                                showCustomMessage(context, 'Your Order is Cancelled by Supplier');
                              },
                              child: Text("Cancel Details")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff1D2221),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                    )),
                                    context: context,
                                    builder: (_) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Order Information",
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: 08),
                                            OrderInfoCard(title: "Name", value: orderInfo['customerName']),
                                            OrderInfoCard(title: "Phone", value: orderInfo['customerPhone']),
                                            OrderInfoCard(title: "Email", value: orderInfo['customerEmail']),
                                            OrderInfoCard(title: "Address", value: orderInfo['customerAddress']),
                                            OrderInfoCard(title: "Payment Status", value: orderInfo['paymentStatus']),
                                            OrderInfoCard(title: "Order Status", value: orderInfo['orderStatus']),
                                            orderInfo['orderStatus'] == "deliver"
                                                ? InkWell(
                                                    onTap: () async {},
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Write Your Review",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Icon(Icons.grade, color: Colors.amber),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Text("View Details")),
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
