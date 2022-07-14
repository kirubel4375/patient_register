import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patient_register/Constants/colors.dart';
import 'package:patient_register/Functions/firebase_api.dart';
import 'package:patient_register/Functions/firebase_auth.dart';
import 'package:patient_register/Screens/home_page.dart';
import 'package:patient_register/Screens/signup.dart';
import 'package:patient_register/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool inAsyncCall = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLoginRegisterColor,
        title: const Text("Login"),
        centerTitle: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomeTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your email..."),
              const SizedBox(height: 5.0),
              CustomeTextField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Enter your password..."),
              const SizedBox(height: 45.0),
              ContainerRoundedButton(
                mainText: "Login",
                onTap: () async {
                  setState(() {
                    inAsyncCall = true;
                  });
                  String approve = await FirebaseApi.checkApproved(
                      email: emailController.text);
                  if (approve == "success") {
                    String? result = await context
                        .read<AuthenticationService>()
                        .signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                    if (result == "sign in successful") {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    }
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(result!)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "$approve you're not approved yet please contact the admin"),
                      duration: const Duration(seconds: 10),
                    ));
                  }
                  setState(() {
                    inAsyncCall = false;
                  });
                },
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text("Don't have an account yet? Sign up"),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
