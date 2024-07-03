import 'package:flutter/material.dart';
import 'api_service.dart';
import 'crypto_model.dart';

void main() {
  runApp(CryptoPriceApp());
}

class CryptoPriceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Harga Crypto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CryptoListPage(),
    );
  }
}

class CryptoListPage extends StatefulWidget {
  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late Future<List<Crypto>> futureCryptos;

  @override
  void initState() {
    super.initState();
    futureCryptos = ApiService().fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Crypto'),
      ),
      body: FutureBuilder<List<Crypto>>(
        future: futureCryptos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal Load Data Crypto'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data Tidak Tersedia'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Crypto crypto = snapshot.data![index];
                return ListTile(
                  title: Text('${crypto.name} (${crypto.symbol})'),
                  subtitle: Text(
                      'Rank: ${crypto.rank}\n24h Change: ${crypto.percentChange24h}%'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
                      Text(
                          'Market Cap: \$${crypto.marketCapUsd.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
