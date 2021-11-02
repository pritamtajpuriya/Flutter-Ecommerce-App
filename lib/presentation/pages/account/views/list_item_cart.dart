import 'package:flutter/material.dart';

class ListItemCart extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onpressed;

  ListItemCart({this.icon, this.title, this.onpressed});
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: InkWell(
        onTap: onpressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: onpressed,
              // padding: EdgeInsets.all(20),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10)),
              // color: Color(0xFFF5F6F9),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: Color(0xFFFF7643),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      title!,
                      style: _theme.appBarTheme.textTheme!.caption,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
