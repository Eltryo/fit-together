import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/firebase_options.dart';
import 'package:fit_together/presentation/home/entry_wrapper.dart';
import 'package:fit_together/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "fit-together",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (kDebugMode) {
  //   try {
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //     await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: [
          StreamProvider<User?>(
            create: (_) => AuthenticationService().authState,
            initialData: null,
          )
        ],
        child: MaterialApp(
          title: "fit-together",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.black,
              ),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            indicatorColor: Colors.teal,
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.teal),
            dividerColor: Colors.black,
          ),
          home: const EntryWrapper(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
