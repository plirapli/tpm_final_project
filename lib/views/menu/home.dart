import 'package:flutter/material.dart';
import 'package:tpm_final_project/components/heading.dart';
import 'package:tpm_final_project/utils/currency.dart';
import 'package:tpm_final_project/utils/product.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDataLoaded = false;
  int totalItems = 0;
  double totalValueOriginal = 0;
  double totalValue = 0;
  String maxItem = "-";

  final List<String> currencies = ['IDR', 'USD', 'KRW', 'JPY', 'EUR', 'GBP'];
  final Map<String, String> currencySymbol = {
    "IDR": "Rp",
    "USD": "\$",
    "KRW": "₩",
    "JPY": "¥",
    "EUR": "€",
    "GBP": "£"
  };
  late String dropdownValue = currencies.first;

  Future? _future;

  @override
  void initState() {
    super.initState();
    _future = _loadAll();
  }

  Future<List<Map<String, dynamic>>> _loadAll() async {
    return await Future.wait([
      ProductApi.getProductTotal(),
      ProductApi.getProductTotalPrice(),
      ProductApi.getMaxPriceProduct(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Heading(
          text: "Hello, ${widget.data["name"]}  👋🏻",
          subtext: "Welcome to Armageddon.",
        ),
        const SizedBox(height: 16),
        FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildError(snapshot.error.toString());
            } else if (snapshot.hasData) {
              if (!_isDataLoaded) {
                _isDataLoaded = true;
                final bool isError = snapshot.data[0]["status"] == "Error" ||
                    snapshot.data[1]["status"] == "Error" ||
                    snapshot.data[2]["status"] == "Error";
                if (isError) return _buildError(snapshot.data["message"]);

                totalItems = int.parse(snapshot.data[0]["data"]);
                totalValue = double.parse(snapshot.data[1]["data"]);
                maxItem = snapshot.data[2]["data"]["name"];
                totalValueOriginal = totalValue;
              }
              return _overview(context);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Widget _overview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Overview",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 23, 47, 39),
          ),
        ),
        const SizedBox(height: 12),
        _cardOverview(
          context,
          icon: Icons.local_shipping,
          text: totalItems.toString(),
          subtext: "Total Items",
          color: Colors.blue,
          subcolor: Colors.blue.shade50,
        ),
        const SizedBox(height: 16),
        _cardValue(
          context,
          text: totalValue.toString(),
          subtext: "Total Value",
        ),
        const SizedBox(height: 16),
        _cardOverview(
          context,
          icon: Icons.attach_money,
          text: maxItem,
          subtext: "Most Expensive Products",
          color: Colors.amber.shade700,
          subcolor: Colors.amber.shade50,
        ),
      ],
    );
  }

  Widget _cardOverview(
    BuildContext context, {
    IconData icon = Icons.flag,
    String text = "Lorem",
    String subtext = "Lorem Ipsum",
    Color color = Colors.black,
    Color subcolor = Colors.black12,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: subcolor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 20),
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
    );
  }

  Widget _cardValue(
    BuildContext context, {
    String text = "Lorem",
    String subtext = "Lorem Ipsum",
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  size: 28,
                  color: Colors.teal,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color.fromARGB(48, 0, 0, 0)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? value) async {
                      var res = await CurrencyApi.convert(
                        totalValueOriginal,
                        currency: value!.toLowerCase(),
                      );
                      totalValue = res["data"] + 0.0;
                      setState(() => dropdownValue = value);
                    },
                    items: currencies.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      },
                    ).toList(),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "${currencySymbol[dropdownValue]}$text",
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
    );
  }

  Widget _buildError(String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(msg),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => setState(() => _future = _loadAll()),
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
