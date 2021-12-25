import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/model/category.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_controller.dart';


class CategoriesTile extends StatelessWidget {
  final controller = Get.find<CatergoriesController>();
  final ValueChanged<int>? onChanged;
  final List<Category>? categoriesList;

  CategoriesTile({this.categoriesList, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            categoriesList!.isEmpty ? 0 : categoriesList!.length,
            (index) => InkWell(
                  onTap: () {
                    onChanged!(index);
                    print(categoriesList![index].title);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 90,
                              child: Center(
                                child: Text(
                                  categoriesList![index].title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              )),
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}
