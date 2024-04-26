import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:community_service/models/user_auth.dart';

// void main(List<String> args) {
//   runApp(MySignIn());
// }

// class MySignIn extends StatelessWidget {
//   const MySignIn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignUp(),
//     );
//   }
// }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  bool _password = true;
  bool _confirmPassword = true;

  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        forceMaterialTransparency: true,
      ),
      backgroundColor: const Color(0xFFECEFF3),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/ASU_Logo.png'),
                    alignment: Alignment.center,
                    width: 300,
                  )
                ],
              ),
              const SizedBox(
                height: 55,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: const Row(
                  children: [
                    Text(
                      "Get Started Now!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Row(
                  children: [
                    Text(
                      "Create New Account",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                        ],
                      ),
                      //width: 370,
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Required!';
                          }
                          if (!(value.contains('@students.asu.edu.jo'))) {
                            return 'Please Enter Your University Email!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Color(0xff8A8B8B),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8FF),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                        ],
                      ),
                      // width: 370,
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Required!';
                          }
                          RegExp regex = RegExp(r'^(?=.*?[0-9]).{8,}$');
                          if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Password must contain at least one number";
                          }
                          return null;
                        },
                        obscureText: _password,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Color(0xff8A8B8B),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8FF),
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _password = !_password;
                              });
                            },
                            child: _password
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xff8A8B8B),
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Color(0xff141617),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 5,
                              color: Color(0x10000000))
                        ],
                      ),
                      child: TextFormField(
                        controller: confirmpasswordController,
                        obscureText: _confirmPassword,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Color(0xff8A8B8B),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8FF),
                          hintText: "Confirm Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmPassword = !_confirmPassword;
                              });
                            },
                            child: _confirmPassword
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xff8A8B8B),
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Color(0xff141617),
                                  ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Required!';
                          } else {
                            if (passwordController.text !=
                                confirmpasswordController.text) {
                              return 'Password Not Matched!';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/signUpInfoScreen');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF144E73),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 114,
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUpFirst() async {
    try {
      await Auth().signUpWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushNamed(context, "/signUpInfoScreen");
    } on FirebaseAuthException catch (e) {
      var sb = const SnackBar(
        content: Text("User already Registered!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
      print(e.message);
    }
  }
}
