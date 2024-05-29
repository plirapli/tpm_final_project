import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpm_final_project/models/category.dart';
import 'package:tpm_final_project/models/product.dart';
import 'package:tpm_final_project/utils/product.dart';

class ProductViewPage extends StatefulWidget {
  final Category category;

  const ProductViewPage({super.key, required this.category});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  String keyword = "";
  Future? _future;
  List<Product> filteredProduct = [];
  List<Product> productList = [];
  List<int> isExpanded = [];

  final List<String> currencies = ['IDR', 'USD', 'KRW', 'JPY', 'EUR', 'GBP'];
  final Map<String, String> currencySymbol = {
    "IDR": "Rp",
    "USD": "\$",
    "KRW": "₩",
    "JPY": "¥",
    "EUR": "€",
    "GBP": "£"
  };
  late String selectedCurrency = currencies.first;

  final List<String> timezones = ['WIB', 'WITA', 'WIT', 'UTC'];
  late String selectedTimezone = timezones.first;

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: currencySymbol[selectedCurrency],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.name!)),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const SizedBox(height: 14),
            _searchBar(context),
            _products(),
          ]),
        ),
        // floatingActionButton: Container(
        //   padding: const EdgeInsets.all(10),
        //   child: FloatingActionButton(
        //     onPressed: () async {
        //       final result = await Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const AddPage()),
        //       );

        //       if (result != null) {
        //         if (!context.mounted) return;
        //         ScaffoldMessenger.of(context)
        //           ..removeCurrentSnackBar()
        //           ..showSnackBar(SnackBar(content: Text(result)));
        //         setState(() {});
        //         _future = TodoApi.getTodo();
        //       }
        //     },
        //     foregroundColor: Colors.black,
        //     backgroundColor: Colors.white,
        //     shape: const RoundedRectangleBorder(
        //       side: BorderSide(
        //         width: 2.5,
        //         strokeAlign: BorderSide.strokeAlignCenter,
        //       ),
        //     ),
        //     elevation: 3,
        //     child: const Icon(Icons.add, size: 32),
        //   ),
        // ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = ProductApi.getProductsByCategory(widget.category.id.toString());
  }

  void _search(String val) {
    keyword = val;
    filteredProduct = productList
        .where((item) =>
            (item.name!.toLowerCase()).contains(val.toLowerCase()) ||
            (item.qty.toString().toLowerCase()).contains(val.toLowerCase()))
        .toList();
    setState(() {});
  }

  Widget _searchBar(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          enabled: true,
          onChanged: (value) => _search(value),
          decoration: InputDecoration(
            hintText: 'Search Product',
            prefixIcon: const Icon(Icons.search, color: Colors.black87),
            filled: true,
            fillColor: const Color.fromARGB(255, 229, 229, 229),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color.fromARGB(48, 0, 0, 0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCurrency,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    onChanged: (String? value) async {
                      // var res = await CurrencyApi.convert(
                      //   totalValueOriginal,
                      //   currency: value!.toLowerCase(),
                      // );
                      // totalValue = res["data"] + 0.0;
                      setState(() => selectedCurrency = value!);
                    },
                    items: currencies.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Text(currencySymbol[value]!),
                                const SizedBox(width: 10),
                                Text(value),
                              ],
                            ));
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color.fromARGB(48, 0, 0, 0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedTimezone,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    onChanged: (String? value) async {
                      // var res = await CurrencyApi.convert(
                      //   totalValueOriginal,
                      //   currency: value!.toLowerCase(),
                      // );
                      // totalValue = res["data"] + 0.0;
                      setState(() => selectedTimezone = value!);
                    },
                    items: timezones.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _products() {
    return Expanded(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Products productModel = Products.fromJson(snapshot.data);
            final bool isError = productModel.status == "Error";
            if (isError) return _error(productModel.message!);

            // Memasukkan list todo ke dalam todoList biar bisa di-search
            productList = [...?productModel.data];
            return _success(context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _error(String msg) {
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

  Widget _success(BuildContext context) {
    return (keyword != "" && filteredProduct.isEmpty)
        ? Container(
            margin: const EdgeInsets.only(top: 12),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  const TextSpan(text: "Can't find "),
                  TextSpan(
                    text: keyword,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " on menu."),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount:
                (keyword != "") ? filteredProduct.length : productList.length,
            itemBuilder: (BuildContext context, int index) {
              List<Product> list =
                  (keyword != "") ? filteredProduct : productList;
              bool isLast = list.last == productList[index];
              bool isFirst = list.first == productList[index];
              return _product(context, list[index], isFirst, isLast);
            },
          );
  }

  Widget _product(
    BuildContext context,
    Product product,
    bool isFirst,
    bool isLast,
  ) {
    DateTime createdAt = DateTime.parse(product.createdAt!).toLocal();
    String formattedDate = DateFormat.yMEd().add_Hm().format(createdAt);

    return Container(
      margin: EdgeInsets.fromLTRB(1, 14, 1, isLast ? 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(128, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          // final result = await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EditPage(id: product.id!),
                          //   ),
                          // );

                          // if (result != null) {
                          //   if (!context.mounted) return;
                          //   ScaffoldMessenger.of(context)
                          //     ..removeCurrentSnackBar()
                          //     ..showSnackBar(SnackBar(content: Text(result)));
                          //   setState(() {});
                          //   _future = ProductApi.getProductsByCategory(
                          //       widget.category.id.toString());
                          // }
                        },
                        child: const Text("Update"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final bool? shouldRefresh = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Product?"),
                                content: Text(
                                    "Do you want to delete ${product.name}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red.shade50,
                                      foregroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final res =
                                          await ProductApi.deleteProduct(
                                        product.id.toString(),
                                      );

                                      if (!context.mounted) return;
                                      Navigator.pop(context, true);
                                      SnackBar snackBar = SnackBar(
                                        content: Text(res["message"]),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2.5,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  ),
                                ),
                              );
                            },
                          );

                          if (shouldRefresh!) {
                            setState(() {});
                            _future = ProductApi.getProductsByCategory(
                              widget.category.id.toString(),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red.shade50,
                            foregroundColor: Colors.red),
                        child: const Text("Delete"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
