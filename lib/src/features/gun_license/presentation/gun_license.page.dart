import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';
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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Lizenzen",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60),
              ),
            ),
            ref.watch(userControllerProvider).when(
                  data: (user) {
                    return user.gunLicense
                        ? Column(
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "${user.firstName} ${user.lastName}",
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 20),
                              Image.asset("assets/images/gun_license.png"),
                              const SizedBox(height: 20),
                              Text("Lizenznummer: ${user.memberId}"),
                              const SizedBox(height: 5),
                              Text("Gültig bis Ende: ${DateTime.now().year}"),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Du hast noch keine Waffenschein"),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        var scaffoldMessenger = ScaffoldMessenger.of(context);

                                        setState(() {
                                          _isLoading = true;
                                        });

                                        bool hasLicenseUpdated = false;

                                        try {
                                          hasLicenseUpdated = await ref
                                              .read(gunLicenseControllerProvider.notifier)
                                              .requestGunLicense(currentLicense: user.gunLicense);
                                        } catch (e) {
                                          log(e.toString());
                                        }

                                        if (hasLicenseUpdated) {
                                          scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                              content: Text("Lizenz beantragt"),
                                            ),
                                          );
                                        } else {
                                          scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                              content: Text("Du kannst noch keine Lizenz beantragen"),
                                            ),
                                          );
                                        }

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                child: const Text("Lizenz beantragen"),
                              ),
                            ],
                          );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text(error.toString()),
                ),
          ],
        ),
      ),
    );
  }
}
