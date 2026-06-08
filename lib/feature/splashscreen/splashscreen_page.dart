import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/feature/splashscreen/splashscreen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final vm = SplashScreenVm(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vm.init();
        });
        return vm;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bgBlackRed),
              fit: BoxFit.cover, // penting biar full layar
            ),
          ),
          child: Center(
            child: Consumer<SplashScreenVm>(
              builder: (context, vm, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logoWhite,
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
