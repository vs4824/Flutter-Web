import 'package:flutter/material.dart';
import 'package:example/view/signup/ui/signup_screen.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:example/view/splash_screen/ui/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await Hive.openBox('my-box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink("http://3.110.75.42:3005/graphql");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
      client: client,
    );
  }
}
