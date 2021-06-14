import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class CartController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  CartController({this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt quantity = 2.obs;
  RxBool loading = false.obs;
  void showButtomSheed(BuildContext context, VoidCallback onTap, int id) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            height: 200,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            10,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      quantity(index + 1);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color:
                                                  quantity.value == (index + 1)
                                                      ? Colors.redAccent
                                                      : Colors.black)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text((1 + index).toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
                  Container(
                      height: 50,
                      color: Colors.redAccent,
                      width: double.infinity,
                      child: Center(child: Text('Done')))
                ],
              );
            })));
  }
}
