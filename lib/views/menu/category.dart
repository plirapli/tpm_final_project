import 'package:flutter/material.dart';
import 'package:tpm_final_project/models/category.dart';
import 'package:tpm_final_project/utils/category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> categories = [];
  Future? _future;

  @override
  void initState() {
    super.initState();
    _future = CategoryApi.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Expanded(
          child: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return _buildError(snapshot.error.toString());
              } else if (snapshot.hasData) {
                Categories categories = Categories.fromJson(snapshot.data);
                final bool isError = categories.status == "Error";
                if (isError) {
                  return _buildError(categories.message.toString());
                }
                return _categories(context, categories.data!);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget _categories(BuildContext context, List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        bool isLast = categories.last == categories[index];
        return _cardOverview(
          context,
          isLast,
          icon: Icons.local_shipping,
          text: categories[index].name!,
          subtext: "${categories[index].itemQty.toString()} items",
          color: Colors.blue,
          subcolor: Colors.blue.shade50,
        );
      },
    );
  }

  Widget _cardOverview(
    BuildContext context,
    bool isLast, {
    IconData icon = Icons.flag,
    String text = "Lorem",
    String subtext = "Lorem Ipsum",
    Color color = Colors.black,
    Color subcolor = Colors.black12,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16, 0, isLast ? 16 : 0),
      child: Material(
        child: InkWell(
          onTap: () {
            print("asdasd");
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black26),
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(128, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(msg),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            _future = CategoryApi.getCategories();
            setState(() {});
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.black12,
            foregroundColor: Colors.black,
          ),
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
