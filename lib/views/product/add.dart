import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpm_final_project/models/product.dart';
import 'package:tpm_final_project/theme.dart';
import 'package:tpm_final_project/utils/product.dart';

class ProductAddPage extends StatefulWidget {
  final int categoryId;
  const ProductAddPage({super.key, required this.categoryId});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();

  bool isError = false;
  String msg = "";

  Future<void> _editHandler(BuildContext context) async {
    try {
      Product product = Product(
        name: _name.text,
        qty: int.parse(_qty.text),
        price: int.parse(_price.text),
        categoryId: widget.categoryId,
      );
      final Map<String, dynamic> response =
          await ProductApi.addProduct(product);
      final status = response["status"];
      msg = response["message"];

      if (status == "Success") {
        if (!context.mounted) return;
        Navigator.pop(context, msg);
      } else {
        throw Exception(msg);
      }
    } catch (e) {
      setState(() => isError = true);
      if (!context.mounted) return;
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _qty.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: MyTheme.bgColor,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(height: 16),
              _heading(),
              _form(context),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _textField("Product Name", _name, null),
        _textField("Quantity", _qty, r'^\d{0,9}'),
        _textField("Price (Rp)", _price, r'^\d{0,12}'),
        const SizedBox(height: 16),
        _editButton(context),
      ],
    );
  }

  Widget _textField(label, controller, regex) {
    Color bgColor =
        (isError) ? MyTheme.errorColor["bg"]! : MyTheme.secondaryColor;
    Color borderColor =
        (isError) ? MyTheme.errorColor["normal"]! : MyTheme.secondaryColor;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          TextFormField(
            enabled: true,
            controller: controller,
            onChanged: (value) {
              setState(() {
                if (isError) isError = false;
              });
            },
            inputFormatters: regex != null
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(regex)),
                  ]
                : null,
            decoration: InputDecoration(
              hintText: label,
              filled: true,
              fillColor: bgColor,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: TextButton(
        onPressed: () => _editHandler(context),
        child: const Text('Add Product'),
      ),
    );
  }

  Widget _heading() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Product 📦",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("Add your product to inventory."),
        ],
      ),
    );
  }
}
