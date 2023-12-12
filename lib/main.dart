import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GifModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Picker con Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.blueGrey,
        ),
      ),
      home: MyHomePage(title: 'Giphy Picker con Provider'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: context.watch<GifModel>().gif == null
              ? const Text('Pulsa el ícono de búsqueda para visualizar los gif.')
              : GiphyImage.original(gif: context.watch<GifModel>().gif!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final gif = await GiphyPicker.pickGif(
            context: context,
            apiKey: 'BIHdnJeNPVDOP1t6TQXX66vMa7kJ92qd',
          );

          if (gif != null) {
            context.read<GifModel>().updateGif(gif);
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'By Daniel Gonzalez B.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class GifModel extends ChangeNotifier {
  GiphyGif? _gif;

  GiphyGif? get gif => _gif;

  void updateGif(GiphyGif newGif) {
    _gif = newGif;
    notifyListeners();
  }
}
