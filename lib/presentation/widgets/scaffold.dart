import 'package:flutter/material.dart';

class SajiloDokanScaffold extends StatelessWidget {
  final Color? background;
  final String? title;

  final Widget body;
  final AppBar? appBar;
  final int? bottomMenuIndex;
  final Widget? bottomNavigationBar;

  const SajiloDokanScaffold(
      {this.background,
      this.appBar,
      required this.title,
      required this.body,
      this.bottomMenuIndex,
      this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: title != null
          ? AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                title!,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ],
                )
              ],
            )
          : appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
