import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';
import 'chat_screen.dart';

class CustomChatList extends StatefulWidget {
  const CustomChatList({Key? key}) : super(key: key);

  @override
  State<CustomChatList> createState() => _CustomChatListState();
}

class _CustomChatListState extends State<CustomChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        title: Text("All Customers", style: AppTextStyles.APPBAR_HEADING_STYLE),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.90,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chat")
              .where("ids", arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "You Have No Chat Yet",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Container(
              height: MediaQuery.sizeOf(context).height*0.9,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  getUserId() {
                    List<dynamic> users = snapshot.data!.docs[index]['ids'];
                    if (users[0] == FirebaseAuth.instance.currentUser!.uid) {
                      return users[1];
                    } else {
                      return users[0];
                    }
                  }

                  return Container(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection("users").doc(getUserId()).snapshots(),
                      builder: (context, snap) {
                        print(snapshot.data!.docs.length);
                        if (snap.hasData) {
                          Map<String, dynamic> customerInfo = snap.data!.data() as Map<String, dynamic>;
                          bool isSupplier = customerInfo['isSuppler'] == true;
                          if (isSupplier) return SizedBox();
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 05),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    navigateToPage(
                                        context,
                                        ChatScreen(
                                          docId: snapshot.data!.docs[index].id,
                                          userId: customerInfo['uid'],
                                          email: customerInfo['email'],
                                          supplierName: customerInfo['userName'],
                                        ));
                                  },
                                  leading: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 05),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(customerInfo['image'], fit: BoxFit.cover),
                                        ),
                                      )),
                                  title: Text(
                                    customerInfo['userName'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['msg'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                                Divider(color: AppColors.primaryColor, thickness: 1, height: 0.1),
                              ],
                            ),
                          );
                        }
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Text('no user');
                        }
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
