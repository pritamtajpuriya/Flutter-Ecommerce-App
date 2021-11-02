import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_controller.dart';
import 'package:sajilo_dokan/presentation/pages/login/views/social_button.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';

class SignForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? name;
  final TextEditingController? email;
  final TextEditingController? password;
  final VoidCallback? logOrRegAction;
  SignForm({this.name, this.email, this.password, this.logOrRegAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<LoginController>();

  void socialLogin(String? idToken, String provider) async {
    final result = await controller.googleAuth(idToken, provider);
    if (result) {
      Get.offAllNamed(SajiloDokanRoutes.landingHome);
    } else {
      Get.snackbar('Error', 'Incorrect Password');
    }
  }

  final googlesignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> fblogin() async {
    final result = await FacebookAuth.instance.login(permissions: [
      'public_profile',
      'email',
    ]);
    if (result.status == LoginStatus.success) {
      log(result.accessToken!.token);
      socialLogin(result.accessToken!.token, 'facebook');
    } else {
      return null;
    }
  }

  Future<void> login() async {
    await googlesignIn
        .signIn()
        .then((result) => result!.authentication)
        .then((googleKey) => socialLogin(googleKey.idToken, 'google'))
        .catchError((err) => null);
  }

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
            DefaultLogo(),
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
                          if (value!.isEmpty) {
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
                      InkWell(
                        onTap: () {
                          navigator!.pushNamed(SajiloDokanRoutes.checkAccount);
                        },
                        child: Text(
                          'Forget Password ?',
                          style: GoogleFonts.blinker(),
                        ),
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
                  if (_formKey.currentState!.validate()) {
                    logOrRegAction!();
                  } else {
                    create();
                  }
                },
                child: DefaultBTN(
                  btnText: btnText,
                )),
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
                    onPressed: login,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SocialButton(
                    imageName: 'assets/images/facebook.png',
                    socialMedia: 'Facebook',
                    color: Colors.blue,
                    onPressed: fblogin,
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
