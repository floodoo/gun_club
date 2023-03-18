import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/extensions/date.extension.dart';
import 'package:gun_club/src/features/upcoming_birthdays/presentation/upcoming_birthdays.controller.dart';

class UpcomingBirthdays extends ConsumerWidget {
  const UpcomingBirthdays({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Anstehende Geburtstage",
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 60),
          ),
        ),
        Expanded(
          child: ref.watch(upcomingBirthdaysControllerProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text("Keine Geburtstage in den nächsten 30 Tagen"));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final birthdayUser = data[index];

                        return Card(
                          child: ListTile(
                            title: Text("${birthdayUser.firstName} ${birthdayUser.lastName}"),
                            subtitle: Text(birthdayUser.dateOfBirth.toDDMMYYYY()),
                            trailing:
                                birthdayUser.dateOfBirth.isToday() ? const Icon(Icons.cake, color: Colors.red) : null,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text(error.toString()),
              ),
        )
      ],
    );
  }
}
