import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_register/Functions/firebase_api.dart';
import 'package:patient_register/models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.docId, required this.docName})
      : super(key: key);
  final String docId;
  final String docName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _myId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.docName),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection("chats")
                  .doc(_myId)
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;
                List<MessageBubbles> messageBubbles = [];
                  for (var message in messages) {
                    final messageText = message.data();
                    Messages aMessage = Messages.fromJson(messageText);
                    MessageBubbles aBubble = MessageBubbles(
                        text: aMessage.message, createdAt: aMessage.createdAt, senderId: aMessage.senderId,);
                    messageBubbles.add(aBubble);
                  }
                return messageBubbles.isEmpty
                      ? Column(
                        children: [
                          const SizedBox(height: 200.0),
                          Center(
                              child: RichText(
                              text: TextSpan(
                                text: "say hi to ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.docName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        ],
                      )
                      : Expanded(
                          child: ListView(
                            reverse: true,
                            children: messageBubbles,
                          ),
                        );
              }),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.attach_file),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      FirebaseApi.uploadMessage(
                          message: textController.text,
                          recieverId: widget.docId);
                      textController.clear();
                    },
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageBubbles extends StatelessWidget {
  const MessageBubbles({Key? key, required this.text, required this.createdAt, required this.senderId})
      : super(key: key);
  final String text;
  final Timestamp createdAt;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final bool isMe = currentUserId == senderId;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe?  CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Material(
              color: isMe? Colors.lightBlue: Colors.black54,
              borderRadius: isMe? BorderRadius.circular(30.0).copyWith(topRight: Radius.zero): BorderRadius.circular(30.0).copyWith(topLeft: Radius.zero),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Text("${createdAt.toDate().hour.toString()}:${createdAt.toDate().minute.toString()}"),
        ],
      ),
    );
  }
}