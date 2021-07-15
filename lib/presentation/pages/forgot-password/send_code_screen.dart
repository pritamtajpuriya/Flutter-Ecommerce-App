import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';
import 'package:sajilo_dokan/presentation/widgets/default_logo.dart';

class SendCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultLogo(),
            Text(
              'Reset Your Password',
              style: CustomTextStyle.headLine,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'We have send a OTP to your email check and verify to reset your password',
              style: CustomTextStyle.lowVisial,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Resend',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                navigator.pushNamed(SajiloDokanRoutes.createNewPassword);
              },
              child: DefaultBTN(
                btnText: 'Verify',
              ),
            )
          ],
        ),
      ),
    );
  }
}
