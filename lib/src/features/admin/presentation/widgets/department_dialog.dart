import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';
import 'package:gun_club/src/features/admin/presentation/department.controller.dart';

Future<void> showDepartmentDialog(BuildContext context, UserDto profile) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return ref.watch(departmentControllerProvider).when(
                data: (departments) {
                  String departmentId = departments.first.departmentId;

                  return AlertDialog(
                    title: Text("Anmeldung von ${profile.firstName} ${profile.lastName}"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField(
                          value: departments.first.departmentId,
                          onChanged: (value) {
                            departmentId = value.toString();
                          },
                          items: departments
                              .map(
                                (department) => DropdownMenuItem(
                                  value: department.departmentId,
                                  child: Text(department.name),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            final scaffoldMessenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);

                            try {
                              await ref
                                  .read(adminControllerProvider.notifier)
                                  .attendUser(userId: profile.memberId, departmentId: departmentId);
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text("${profile.firstName} ${profile.lastName} wurde angemeldet"),
                                ),
                              );
                              navigator.pop();
                            } catch (e) {
                              log(e.toString());
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Fehler beim anmelden von ${profile.firstName} ${profile.lastName}",
                                  ),
                                ),
                              );
                              navigator.pop();
                            }
                          },
                          child: const Text("Anmelden"),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
              );
        },
      );
    },
  );
}
// return ref.watch(departmentControllerProvider).when(
//       data: (departments) {
//         return showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("Anmeldung von ${profile.firstName} ${profile.lastName}"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ref.watch(departmentControllerProvider).when(
//                     data: (departments) {
//                       return DropdownButtonFormField(
//                         value: departments,
//                         items: departments
//                             .map(
//                               (department) => DropdownMenuItem(
//                                 value: department.departmentId,
//                                 child: Text(department.name),
//                               ),
//                             )
//                             .toList(),
//                         onChanged: (value) async {
//                           final scaffoldMessenger = ScaffoldMessenger.of(context);
//                           try {
//                             await ref
//                                 .read(adminControllerProvider.notifier)
//                                 .updateUserType(userId: profile.memberId, userTypeId: value as int);
//                             scaffoldMessenger.showSnackBar(
//                               SnackBar(
//                                 content: Text("${profile.firstName} ${profile.lastName} wurde angemeldet"),
//                               ),
//                             );
//                           } catch (e) {
//                             log(e.toString());
//                             scaffoldMessenger.showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   "Fehler beim anmelden von ${profile.firstName} ${profile.lastName}",
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       );
//                     },
//                     error: (error, stack) => Text(error.toString()),
//                     loading: () => const CircularProgressIndicator()),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text("Abbrechen"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final scaffoldMessenger = ScaffoldMessenger.of(context);
//                   try {
//                     await ref.read(adminControllerProvider.notifier).attendUser(userId: profile.memberId);
//                     scaffoldMessenger.showSnackBar(
//                       SnackBar(
//                         content: Text("${profile.firstName} ${profile.lastName} wurde angemeldet"),
//                       ),
//                     );
//                   } catch (e) {
//                     log(e.toString());
//                     scaffoldMessenger.showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           "Fehler beim anmelden von ${profile.firstName} ${profile.lastName}",
//                         ),
//                       ),
//                     );
//                   }
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text("Anmelden"),
//               ),
//             ],
//           ),
//         );
//       },
//       error: (error, stack) => showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Fehler"),
//           content: Text(error.toString()),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("Abbrechen"),
//             ),
//           ],
//         ),
//       ),
//       loading: () => showDialog(
//         context: context,
//         builder: (context) => const AlertDialog(
//           title: Text("Lade Abteilungen"),
//           content: CircularProgressIndicator(),
//         ),
//       ),
//     );
// }
