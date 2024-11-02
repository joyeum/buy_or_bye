import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [FngIndexModelSchema],
    directory : dir.path,
  );
  GetIt.I.registerSingleton<Isar>(isar);

  runApp(
    MaterialApp(
      home: HomeScreen(),
    )
  );
}