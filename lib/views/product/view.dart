import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            _heading(context),
            _buildTodoList(),
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

  Widget _heading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 16),
        color: const Color.fromARGB(255, 246, 246, 246),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product List",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            _searchBar(context)
          ],
        ));
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        enabled: true,
        onChanged: (value) => _search(value),
        decoration: const InputDecoration(
          hintText: 'Search todo',
          prefixIcon: Icon(Icons.search, color: Colors.black54),
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.75,
              color: Colors.black26,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            borderRadius: BorderRadius.zero,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.75,
              color: Colors.black,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return Expanded(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Products productModel = Products.fromJson(snapshot.data);
            final bool isError = productModel.status == "Error";
            if (isError) return _buildError(productModel.message!);

            // Memasukkan list todo ke dalam todoList biar bisa di-search
            productList = [...?productModel.data];
            return _buildSuccess(context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
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

  Widget _buildSuccess(BuildContext context) {
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
              return _buildTodoItem(context, list[index], isLast);
            },
          );
  }

  Widget _buildTodoItem(BuildContext context, Product product, bool isLast) {
    return Container(
      margin: EdgeInsets.fromLTRB(1, 16, 1, isLast ? 16 : 0),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              if (isExpanded.contains(product.id)) {
                isExpanded.remove(product.id!);
              } else {
                isExpanded.add(product.id!);
              }
              setState(() {});
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.price.toString(),
                  overflow: isExpanded.contains(product.id)
                      ? TextOverflow.clip
                      : TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () async {
          //           final result = await Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => EditPage(id: product.id!),
          //             ),
          //           );

          //           if (result != null) {
          //             if (!context.mounted) return;
          //             ScaffoldMessenger.of(context)
          //               ..removeCurrentSnackBar()
          //               ..showSnackBar(SnackBar(content: Text(result)));
          //             setState(() {});
          //             _future = TodoApi.getTodo();
          //           }
          //         },
          //         child: const Text("Update"),
          //       ),
          //     ),
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () async {
          //           final bool? shouldRefresh = await showDialog<bool>(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 title: const Text("Delete todo?"),
          //                 content:
          //                     Text("Do you want to delete ${product.title}?"),
          //                 actions: [
          //                   TextButton(
          //                     onPressed: () => Navigator.pop(context, false),
          //                     child: const Text("No"),
          //                   ),
          //                   TextButton(
          //                     style: TextButton.styleFrom(
          //                       backgroundColor: Colors.transparent,
          //                       foregroundColor: Colors.red,
          //                     ),
          //                     onPressed: () {
          //                       TodoApi.deleteTodo((product.id).toString())
          //                           .then(
          //                         (value) => Navigator.pop(context, true),
          //                       );
          //                     },
          //                     child: const Text("Yes"),
          //                   ),
          //                 ],
          //                 backgroundColor: Colors.white,
          //                 surfaceTintColor: Colors.transparent,
          //                 shape: const RoundedRectangleBorder(
          //                   side: BorderSide(
          //                     width: 2.5,
          //                     strokeAlign: BorderSide.strokeAlignCenter,
          //                   ),
          //                 ),
          //               );
          //             },
          //           );

          //           if (shouldRefresh!) {
          //             setState(() {});
          //             _future = TodoApi.getTodo();
          //           }
          //         },
          //         style: TextButton.styleFrom(
          //             backgroundColor: Colors.red.shade50,
          //             foregroundColor: Colors.red),
          //         child: const Text("Delete"),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
