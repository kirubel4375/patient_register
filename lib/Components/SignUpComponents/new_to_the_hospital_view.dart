// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:patient_register/Widgets/widgets.dart';
// import 'package:patient_register/models/user_model.dart';
// import 'package:provider/provider.dart';

// import '../../Functions/firebase_auth.dart';

// class NewToTheHospital extends StatefulWidget {
//   const NewToTheHospital({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<NewToTheHospital> createState() => _NewToTheHospitalState();
// }

// class _NewToTheHospitalState extends State<NewToTheHospital> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController birthDayController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         CustomeTextField(
//             controller: firstNameController,
//             hintText: "Full name",
//             keyboardType: TextInputType.name),
//         CustomeTextField(
//           controller: emailController,
//           hintText: "Email",
//           keyboardType: TextInputType.emailAddress,
//         ),
//         CustomeTextField(
//           controller: phoneNumberController,
//           hintText: "Phone number",
//           keyboardType: TextInputType.phone,
//         ),
//         CustomeTextField(
//           controller: birthDayController,
//           hintText: "Birthday",
//           keyboardType: TextInputType.datetime,
//         ),
//         CustomeTextField(
//           controller: passwordController,
//           hintText: "Password",
//           obscureText: true,
//         ),
//         const SizedBox(height: 10.0),
//         ContainerRoundedButton(
//           onTap: () async {
//             String? result = await context.read<AuthenticationService>().signUp(
//                 email: emailController.text.trim(),
//                 password: passwordController.text.trim());
//             if (result == "sign up successful") {
//               final firestore = FirebaseFirestore.instance;
//               final auth = FirebaseAuth.instance;
//               final currentUserID = auth.currentUser!.uid;
//               await firestore
//                   .collection("patients")
//                   .doc(currentUserID)
//                   .set(Patient(
//                     id: currentUserID,
//                     immadiateDocId: '',
//                     lastMessageTime: Timestamp.now(),
//                     name: firstNameController.text,
//                     birthDate: birthDayController.text,
//                     phone: phoneNumberController.text,
//                     address: addressController.text,
//                     orderUuids: [],
//                     approved: false,
//                   ).toJson());
//               Navigator.pop(context, currentUserID);
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 duration: const Duration(seconds: 12),
//                 content: Text(
//                     "${result!}. Please wait until the addmin approve you to login!"),
//               ));
//             } else {
//               ScaffoldMessenger.of(context)
//                   .showSnackBar(SnackBar(content: Text(result!)));
//             }
//           },
//           mainText: "Register",
//         ),
//       ],
//     );
//   }
// }
