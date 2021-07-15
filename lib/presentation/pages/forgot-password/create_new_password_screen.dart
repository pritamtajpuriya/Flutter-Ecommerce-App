import 'package:flutter/material.dart';
import 'package:sajilo_dokan/config/theme.dart';
import 'package:sajilo_dokan/presentation/widgets/default_btn.dart';

class CreateNewPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Create New Password',
              style: CustomTextStyle.headLine,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your new password must be different from previous used passwords',
              style: CustomTextStyle.lowVisial,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'password',
                  hintStyle: CustomTextStyle.lowVisial,
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultBTN(
              btnText: 'Reset Password',
            )
          ],
        ),
      ),
    );
  }
}
