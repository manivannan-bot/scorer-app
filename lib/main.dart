import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scorer/provider/player_selection_provider.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:sizer/sizer.dart';
import 'Scoring screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScoringProvider()),
        ChangeNotifierProvider(create: (context) => PlayerSelectionProvider()),
      ],
      child:  const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive || state == AppLifecycleState.detached){
      return;
    }

    final isBackground = state == AppLifecycleState.paused;
    final isResumed = state == AppLifecycleState.resumed;
    if(isBackground){
      print("app went background");
    } else if(isResumed){
      print("app is live again");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)  {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        }
    );
  }
}
