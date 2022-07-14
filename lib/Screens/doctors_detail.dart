import 'package:flutter/material.dart';
import 'package:patient_register/Screens/chat_screen.dart';

class DocDetail extends StatelessWidget {
  const DocDetail({
    Key? key,
    required this.docName,
    required this.specialization,
    required this.docId,
    required this.requestList,
  }) : super(key: key);
  final String docName;
  final String docId;
  final List requestList;
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(docName),
        ),
        body: Column(
          children: [
            const Spacer(),
            Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 17.0, vertical: 22.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.person, size: 40.0),
                    ),
                    const SizedBox(height: 12.0,),
                    Table(
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        TableRow(
                          children: [
                            const Text("name: "),
                            Text(
                      "Dr.$docName",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(height: 10.0),
                            SizedBox(height: 10.0),
                          ]
                        ),
                        TableRow(
                          children: [
                            const Text("specialization: "),
                            Text(
                      specialization,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.5),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ChatScreen(
                                    docId: docId, docName: docName))));
                      },
                      child: const Text("Chat"),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
