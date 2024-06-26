import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/dashboard/widget/dashboard_screen_card.dart';

import '../../../constants/app_assets.dart';
import '../widgets/custom_appbar_header.dart';
import 'notification/notification_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _totalProducts = 0;
  int _totalOrders = 0;
  double _totalSales = 0.0;
  double overallRating = 0.0;

  _getDashboardInformation() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('products')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    QuerySnapshot orderSnap = await FirebaseFirestore.instance
        .collection('orders')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    QuerySnapshot salesSnap = await FirebaseFirestore.instance
        .collection('orders')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('orderStatus', isEqualTo: 'deliver')
        .get();
    for (var total in salesSnap.docs) {
      _totalSales += total['orderPrice'];
    }

    _totalProducts = snap.docs.length;
    _totalOrders = orderSnap.docs.length;
    setState(() {});
  }

  Future<void> _fetchOverallRating() async {
    double totalSum = 0.0;
    int totalReviews = 0;

    QuerySnapshot productSnap = await FirebaseFirestore.instance
        .collection('products')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    for (var productDoc in productSnap.docs) {
      QuerySnapshot reviewsSnap =
          await FirebaseFirestore.instance.collection('products').doc(productDoc.id).collection('reviews').get();

      for (var review in reviewsSnap.docs) {
        totalSum += review['rating'];
      }
      totalReviews += reviewsSnap.size;
    }

    setState(() {
      overallRating = totalReviews != 0 ? totalSum / totalReviews : 0.0;
    });
  }

  @override
  void initState() {
    _getDashboardInformation();
    _fetchOverallRating();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarHeader(
          widget: Icon(Icons.dashboard),
          title: "Dashboard",
          suffixWidget: GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: SizedBox(
              height: 20,
              width: 25,
              child: Image.asset(AppAssets.notification),
            ),
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 5,
            ),
            children: [
              DashBoardScreenCard(
                onPressed: () {},
                icon: Icons.shopping_bag,
                title: "Products",
                quantity: _totalProducts.toString(),
              ),
              DashBoardScreenCard(
                icon: Icons.grade_outlined,
                title: "Rating",
                onPressed: () {},
                quantity: "${overallRating.toStringAsFixed(1)}",
              ),
              DashBoardScreenCard(
                icon: Icons.note_alt_outlined,
                onPressed: () {},
                title: "Total\nOrders",
                quantity: _totalOrders.toString(),
              ),
              DashBoardScreenCard(
                onPressed: () {},
                title: "Total\nSales",
                quantity: "\$ ${_totalSales.toStringAsFixed(1)}",
                icon: Icons.bar_chart,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
