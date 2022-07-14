import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patient_register/Constants/colors.dart';
import 'package:patient_register/Functions/enums.dart';
import 'package:patient_register/Screens/login.dart';
import 'package:provider/provider.dart';

import '../Functions/firebase_auth.dart';
import '../Widgets/widgets.dart';
import '../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String gender = "female";
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kLoginRegisterColor,
          centerTitle: false,
          title: const Text("Register"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomeTextField(
                            controller: firstNameController,
                            hintText: "Full name",
                            keyboardType: TextInputType.name),
                        CustomeTextField(
                          controller: emailController,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomeTextField(
                          controller: phoneNumberController,
                          hintText: "Phone number",
                          keyboardType: TextInputType.phone,
                        ),
                        CustomeTextField(
                          controller: birthDayController,
                          hintText: "Birthday",
                          keyboardType: TextInputType.datetime,
                        ),
                        Row(
                          children: [
                            const Text("Gender: "),
                            DropdownButton(
                              value: gender,
                                items: ["female", "male"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? value){
                                  setState(() {
                                    gender = value!;
                                  });
                                })
                          ],
                        ),
                        CustomeTextField(
                          controller: addressController,
                          hintText: "Address",
                        ),
                        CustomeTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                        ),
                        const SizedBox(height: 10.0),
                        ContainerRoundedButton(
                          onTap: () async {
                            setState(() {
                              inAsyncCall = true;
                            });
                            String? result = await context
                                .read<AuthenticationService>()
                                .signUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                            if (result == "sign up successful") {
                              final firestore = FirebaseFirestore.instance;
                              final auth = FirebaseAuth.instance;
                              final currentUserID = auth.currentUser!.uid;
                              await firestore
                                  .collection("patients")
                                  .doc(currentUserID)
                                  .set(Patient(
                                    gender: gender,
                                    id: currentUserID,
                                    immadiateDocId: '',
                                    lastMessageTime: Timestamp.now(),
                                    name: firstNameController.text,
                                    birthDate: birthDayController.text,
                                    phone: phoneNumberController.text,
                                    address: addressController.text,
                                    orderUuids: [],
                                    approved: false,
                                    email: emailController.text,
                                  ).toJson());
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                  (route) => false);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 12),
                                content: Text(
                                    "${result!}. Please wait until the addmin approve you to login!"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(result!)));
                            }
                            setState(() {
                              inAsyncCall = false;
                            });
                          },
                          mainText: "Register",
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
