import 'package:dhuwitku/feature/splashscreen/splashscreen_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dhuwitku',
      builder: (context, child) {
        if (!kIsWeb) {
          return child!;
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return child!;
            }

            return Container(
              color: Colors.white,
              child: Center(
                child: SizedBox(
                  width: 560,
                  child: Material(color: Colors.white, child: child!),
                ),
              ),
            );
          },
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        fontFamily: 'HostGrotesk',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home: const SplashScreenPage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Dhuwitku',
//       theme: ThemeData(
//         useMaterial3: true,
//         pageTransitionsTheme: PageTransitionsTheme(
//           builders: {
//             TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//             TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//           },
//         ),
//         fontFamily: 'HostGrotesk',
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(fontWeight: FontWeight.w400),
//           bodyMedium: TextStyle(fontWeight: FontWeight.w400),
//           titleMedium: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       home: const SplashScreenPage(),
//     );
//   }
// }
