import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';

class CategoriesTile extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();
  final ValueChanged<int> onChanged;
  final List categoriesList;
  CategoriesTile({this.categoriesList, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            categoriesList.isEmpty ? 0 : categoriesList.length,
            (index) => InkWell(
                  onTap: () {
                    onChanged(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.withOpacity(1 / (index + 1)),
                        ),
                        child: Center(
                          child: Text(
                            categoriesList[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ))
      ],
    );
  }
}
