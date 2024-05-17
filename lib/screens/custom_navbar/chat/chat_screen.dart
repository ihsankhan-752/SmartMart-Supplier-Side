import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/widgets/text_input.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/loading_controller.dart';
import '../../../model/message_model.dart';
import '../../../services/chat_services.dart';

class ChatScreen extends StatefulWidget {
  final String? customerId;
  const ChatScreen({Key? key, this.customerId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  String enteredMsg = '';
  String? docId;
  String myId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    if (myId.hashCode > widget.customerId.hashCode) {
      docId = myId + widget.customerId!;
    } else {
      docId = widget.customerId! + myId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Direct Chat',
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            color: AppColors.primaryBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("chat")
                    .doc(docId)
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
                      child: Text(
                        "No Previous Chat Found \nwith This Supplier",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        MessageModel messageModel = MessageModel.fromMap(snapshot.data!.docs[index]);
                        return Row(
                          mainAxisAlignment: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.6,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                  color: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid
                                      ? AppColors.grey
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    messageModel.msg!,
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                    ),
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextInput(
                controller: controller,
                hintText: 'Type Something....',
                suffixWidget: Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return IconButton(
                    onPressed: () {
                      ChatServices()
                          .sendMessages(
                        context: context,
                        msg: controller.text,
                        docId: docId!,
                        otherUserId: widget.customerId!,
                      )
                          .then((value) {
                        controller.clear();
                        FocusScope.of(context).unfocus();
                      });
                    },
                    icon: loadingController.isLoading
                        ? CircularProgressIndicator()
                        : Icon(FontAwesomeIcons.paperPlane, size: 25, color: AppColors.primaryColor),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
