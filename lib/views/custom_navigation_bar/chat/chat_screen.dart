import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class ChatScreen extends StatefulWidget {
  final String? docId;
  final String? supplierName;
  final String? userId;
  final String? email;
  const ChatScreen({Key? key, this.docId, this.supplierName, this.userId, this.email}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  String enteredMsg = '';
  @override
  void dispose() {
    widget.userId;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(
          widget.supplierName!,
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/bg.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(AppColors.primaryBlack.withOpacity(0.3), BlendMode.srcATop),
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chat")
                      .doc(widget.docId)
                      .collection("messages")
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No Previous Chat Found with This Customer"),
                      );
                    } else {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          return Row(
                            mainAxisAlignment: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              data['uid'] == FirebaseAuth.instance.currentUser!.uid
                                  ? SizedBox()
                                  : CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(data['customerImage']),
                                    ),
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                                      ? AppColors.primaryColor
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    data['msg'],
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                        child: TextField(
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                          ),
                          controller: controller,
                          onChanged: (v) {
                            setState(() {
                              enteredMsg = v;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message....",
                            hintStyle: TextStyle(
                              color: AppColors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                try {
                                  if ((await FirebaseFirestore.instance.collection("chat").doc(widget.docId).get())
                                      .exists) {
                                    FirebaseFirestore.instance.collection("chat").doc(widget.docId).update({
                                      "msg": enteredMsg,
                                    });
                                  } else {
                                    FirebaseFirestore.instance.collection("chat").doc(widget.docId).set({
                                      "msg": enteredMsg,
                                      "ids": [widget.userId, FirebaseAuth.instance.currentUser!.uid],
                                    });
                                  }
                                  DocumentSnapshot user = await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .get();
                                  FirebaseFirestore.instance
                                      .collection("chat")
                                      .doc(widget.docId)
                                      .collection("messages")
                                      .add({
                                    "createdAt": DateTime.now(),
                                    "uid": FirebaseAuth.instance.currentUser!.uid,
                                    "msg": enteredMsg,
                                    "customerName": user['userName'],
                                    "customerImage": user['image'],
                                    "customerPhone": user['phone'],
                                  }).then((value) {
                                    controller.clear();
                                    FocusScope.of(context).unfocus();
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: Icon(FontAwesomeIcons.paperPlane, size: 25, color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
