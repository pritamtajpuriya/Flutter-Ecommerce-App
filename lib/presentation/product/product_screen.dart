import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 50,
          mainAxisSpacing: 16,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              width: 100,
              color: Colors.red,
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
    );
  }
}
