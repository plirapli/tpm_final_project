import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpm_final_project/models/category.dart';
import 'package:tpm_final_project/models/product.dart';
import 'package:tpm_final_project/theme.dart';
import 'package:tpm_final_project/utils/category.dart';
import 'package:tpm_final_project/utils/product.dart';

class ProductEditPage extends StatefulWidget {
  final int id;
  const ProductEditPage({super.key, required this.id});

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();

  bool _isDataLoaded = false;
  bool isError = false;
  String msg = "";
  Future? _future;
  List<Category> categories = [];
  late int selectedCat;

  Future<void> _editHandler(BuildContext context) async {
    try {
      Product product = Product(
        id: widget.id,
        name: _name.text,
        qty: int.parse(_qty.text),
        price: int.parse(_price.text),
        categoryId: selectedCat,
      );
      final Map<String, dynamic> response =
          await ProductApi.editProduct(product);
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

  Future<List<Map<String, dynamic>>> _loadAll() async {
    return await Future.wait([
      ProductApi.getProductById(widget.id.toString()),
      CategoryApi.getCategories()
    ]);
  }

  @override
  void initState() {
    super.initState();
    _future = _loadAll();
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
        appBar: AppBar(title: const Text("Edit Product")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: MyTheme.bgColor,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(height: 8),
              _content(),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        final height = MediaQuery.of(context).size.height;
        if (snapshot.hasError) {
          return _buildError(snapshot.error.toString());
        } else if (snapshot.hasData) {
          if (!_isDataLoaded) {
            _isDataLoaded = true;
            final bool isError = snapshot.data[0]["status"] == "Error" ||
                snapshot.data[1]["status"] == "Error";
            if (isError) return _buildError(snapshot.data[0]["message"]);

            Product productModel = Product.fromJson(snapshot.data[0]["data"]);
            _name.text = productModel.name!;
            _qty.text = productModel.qty.toString();
            _price.text = productModel.price.toString();

            Categories catModel = Categories.fromJson(snapshot.data[1]);
            categories = catModel.data!;
            selectedCat = productModel.categoryId!;
          }
          return _form(context);
        }
        return _buildLoading(height * 0.65);
      },
    );
  }

  Widget _buildLoading(double height) {
    return SizedBox(
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(String msg) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
        const SizedBox(height: 14),
        _categoryField(),
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

  Widget _categoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Category"),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color.fromARGB(48, 0, 0, 0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: selectedCat,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              onChanged: (int? value) async {
                // var res = await CurrencyApi.convert(
                //   totalValueOriginal,
                //   currency: value!.toLowerCase(),
                // );
                // totalValue = res["data"] + 0.0;
                setState(() => selectedCat = value!);
              },
              items: categories.map<DropdownMenuItem<int>>(
                (Category cat) {
                  return DropdownMenuItem<int>(
                    value: cat.id,
                    child: Text(cat.name!),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _editButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: TextButton(
        onPressed: () => _editHandler(context),
        child: const Text('Save'),
      ),
    );
  }
}
