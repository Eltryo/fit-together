import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/services/provider.dart';

class SubmitRegistration extends ConsumerWidget {
  const SubmitRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = ref.watch(CustomProvider.emailProvider);
    return Text(email);
  }
}
