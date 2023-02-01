import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/features/gun_license/presentation/gun_license.controller.dart';

class GunLicensePage extends ConsumerStatefulWidget {
  const GunLicensePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GunLicensePageState();
}

class _GunLicensePageState extends ConsumerState<GunLicensePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ref.watch(gunLicenseControllerProvider).when(
          data: (license) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text("Has gun license: ${license.gunLicense.toString()}"),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 1));
                            setState(() {
                              _isLoading = false;
                            });
                          },
                    child: const Text("Lizenz beantragen"),
                  )
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
