import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/social_button.dart';

class SignForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback logOrRegAction;
  SignForm({this.name, this.email, this.password, this.logOrRegAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<LoginController>();

  Widget buildSignType() {
    final title = controller.isSignIn.value ? 'Welcome,' : 'Create Account';
    final primary = controller.isSignIn.value
        ? 'Sign In To  Continue!'
        : 'Sign Up To Get Started!';

    final btnText = controller.isSignIn.value ? 'Login' : 'Create';
    final secondary =
        controller.isSignIn.value ? 'Need an account?' : 'Have you account?';

    final signInOrRegister = controller.isSignIn.value ? 'Register' : 'SignIn';

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/logos/logo.png',
                      height: 100,
                    ),
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.ubuntu(
                      textStyle:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(primary, style: GoogleFonts.abel(fontSize: 18)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Container(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!controller.isSignIn.value)
                      Container(
                        child: TextFormField(
                          controller: name,
                          autofillHints: [AutofillHints.name],
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Full Name ',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: email,
                        autofillHints: [AutofillHints.email],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }
                          if (!value.contains('@')) {
                            return 'A valid email is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email ',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller: password,
                        obscureText: controller.showPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleShowPassword();
                              },
                              icon: controller.showPassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          hintText: 'Password',
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (controller.isSignIn.value)
                      Text(
                        'Forget Password ?',
                        style: GoogleFonts.blinker(),
                      ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  logOrRegAction();
                } else {
                  create();
                }
              },
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizes.buttonRadius),
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.orange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Center(
                    child: Text(
                      btnText,
                      style: GoogleFonts.openSans(
                          textStyle:
                              TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text('Or Login Using Social Media',
                    style: GoogleFonts.arvo())),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialButton(
                    imageName: 'assets/images/search.png',
                    socialMedia: 'Google',
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SocialButton(
                    imageName: 'assets/images/facebook.png',
                    socialMedia: 'Facebook',
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(child: Text('___________')),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(secondary, style: GoogleFonts.rubik()),
                InkWell(
                  onTap: () {
                    controller.toggleFormType();
                  },
                  child: Text(signInOrRegister,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(fontWeight: FontWeight.bold))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return buildSignType();
    });
  }
}
