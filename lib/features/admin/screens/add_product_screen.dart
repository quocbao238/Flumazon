import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flumazon/common/widgets/custom_button.dart';
import 'package:flumazon/common/widgets/custom_textfield.dart';
import 'package:flumazon/common/widgets/loading_widget.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/constants/utils.dart';
import 'package:flumazon/features/admin/services/admin_service.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String categorySelect = GlobalVariables.categoryImages.first['title'] ?? '';
  List<String> productCategories = [];
  List<File> images = [];
  final AdminService adminService = AdminService();

  bool _loading = false;

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    productCategories =
        GlobalVariables.categoryImages.map((e) => e['title'] ?? '').toList();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        centerTitle: true,
        title: const Text('Add Product'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Form(
                key: _addProductFormKey,
                child: Column(
                  children: [
                    images.isEmpty
                        ? GestureDetector(
                            onTap: () => _onSelectImages(),
                            child: DottedBorder(
                              color: Colors.black,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                      color: Colors.grey.shade600,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        'Select Product Image',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                              autoPlay: true,
                            ),
                            items: images
                                .map((e) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ))
                                .toList(),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: CustomTextField(
                        controller: productNameController,
                        hintText: 'Product Name',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomTextField(
                        controller: descriptionController,
                        hintText: 'Description',
                        maxLine: 6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomTextField(
                        controller: priceController,
                        hintText: 'Price',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomTextField(
                        controller: quantityController,
                        hintText: 'Quantity',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16.0),
                      width: double.infinity,
                      child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: categorySelect,
                          onChanged: (String? newValue) {
                            setState(() {
                              categorySelect = newValue ?? '';
                            });
                          },
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomButton(
                          title: 'Sell', onTap: () => sellProduct()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_loading) const LoadingWidget()
        ],
      ),
    );
  }

  Future<void> _onSelectImages() async {
    var res = await picksImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      setState(() {
        _loading = true;
      });
      adminService.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          quantity: double.tryParse(quantityController.text) ?? 0.0,
          price: double.tryParse(quantityController.text) ?? 0.0,
          category: categorySelect,
          images: images,
          onSuccess: () {
            setState(() {
              _loading = false;
            });
            Future.delayed(const Duration(milliseconds: 500))
                .then((_) => Navigator.of(context).pop());
          });
    }
  }
}
