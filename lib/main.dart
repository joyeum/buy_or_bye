import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/screen/home_screen.dart';
import 'package:buy_or_bye/screen/test/shimmer_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [MetadataSchema, FngIndexModelSchema],
    directory: dir.path,
  );
  GetIt.I.registerSingleton<Isar>(isar);

  //기존 코드 주석 처리
  runApp(
    MaterialApp(
      home: HomeScreen(),
      // 다국어 지원 설정 추가
      localizationsDelegates: const [
        AppLocalizations.delegate, // 추가
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'), // 한국어
        Locale('en'), // 영어
      ],
      // 시스템 언어를 따르도록 설정 (선택사항)
      // locale: Locale('ko'), // 강제로 한국어 설정하려면 주석 해제
    ),
  );

  // Shimmer 테스트를 위한 임시 코드
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy or Bye',
      theme: ThemeData(
        // ... 기존 테마 설정 ...
      ),
      // HomeScreen 대신 ShimmerTestScreen을 임시로 사용
      home: const ShimmerTestScreen(),
    );
  }
}