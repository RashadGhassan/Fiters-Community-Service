import 'package:community_service/screens/signUpScreen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:community_service/models/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// void main(List<String> args) {
//   runApp(MyPage());
// }

// class MyPage extends StatelessWidget {
//   const MyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignUpInfo(),
//     );
//   }
// }

class SignUpInfo extends StatefulWidget {
  const SignUpInfo({super.key});

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

final _formkey = GlobalKey<FormState>();
List<String> collegeList = ["Information Technology"];
var _selectedItemCollege;
List<String> majorList = [
  "Software Engineering",
  "Computer Science",
  "Cybersecurity and Cloud Computing",
  "Data Science and Artificial Intelligence",
  "Extended Reality and Games Development",
  "Master in Computer Science",
];
var selectedItemMajor;
final TextEditingController fNameController = TextEditingController();
final TextEditingController lNameController = TextEditingController();
final TextEditingController studentNumController = TextEditingController();
final TextEditingController phoneNumController = TextEditingController();

class _SignUpInfoState extends State<SignUpInfo> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     IconButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         icon: Icon(Icons.arrow_back_ios)),
              //   ],
              // ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/complete_signup.png'),
                    alignment: Alignment.center,
                    height: 200,
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  children: [
                    Text(
                      "Almost There!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  children: [
                    Text(
                      "Complete Your Information",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * 0.48,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: fNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Required!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
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
                              hintText: "First Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 20),
                          width: MediaQuery.of(context).size.width * 0.48,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: lNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field Required!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
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
                              hintText: "Last Name",
                            ),
                          ),
                        )
                      ],
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
                      child: TextFormField(
                        controller: studentNumController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Required!';
                          }
                          RegExp regex = RegExp(r'^(?=.*?[0-9]).{9,}$');
                          if (!regex.hasMatch(value)) {
                            return "Please Enter a Valid Student ID";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
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
                          hintText: "Student ID",
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
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Required!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
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
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8FF),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              )),
                              validator: (value) {
                                if (value == null) {
                                  return 'Field Required!';
                                }
                                return null;
                              },
                              isExpanded: true,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              value: selectedItemMajor,
                              hint: const Text(
                                "Major",
                                style: TextStyle(
                                  color: Color(0xff8A8B8B),
                                  fontSize: 16,
                                ),
                              ),
                              items: majorList.map<DropdownMenuItem<String>>(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                },
                              ).toList(),
                              onChanged: (newValue) {
                                setState(
                                  () {
                                    selectedItemMajor = newValue!;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _handleSignUp();
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
                          "Submit",
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

  Future<void> _handleSignUp() async {
    try {
      await Auth()
          .signUpWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .whenComplete(() {
        Map<dynamic, dynamic> user = {
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
          "fName": fNameController.text.toString(),
          "lName": lNameController.text.toString(),
          "phoneNum": phoneNumController.text.toString(),
          "studentId": studentNumController.text.toString(),
          "major": selectedItemMajor.toString(),
        };
        var userID = Auth().auth.currentUser!.uid;

        userRef.child(userID).set(user).whenComplete(() {
          print("user added to database");
          emailController.clear();
          passwordController.clear();
          fNameController.clear();
          lNameController.clear();
          phoneNumController.clear();
          studentNumController.clear();
          Navigator.pushNamed(context, '/homeScreen');
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("users");
}
