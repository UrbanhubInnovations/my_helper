import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/hive/hive_adapter.dart';
import 'core/injection/injection.dart';
import 'core/provider/base/multi_providers.dart';
import 'core/repository/settings/settings_repository.dart';
import 'core/router/app_router.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// @pragma('vm:entry-point')
// void backgroundMessageHandler(SmsMessage message) async {
//   Vibration.vibrate(duration: 1000);
//   log(message.toString());
//   log('Background');
//
//   List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
//
//   log(contacts.toString());
//
//   Contact? contact;
//   for (var element in contacts) {
//     log(element.toJson().toString());
//     if(element.displayName.contains(message.body ?? 'Not Found')){
//       contact = element;
//     }
//   }
//   Telephony.backgroundInstance.sendSms(to: "8714359066", message: "Message from Background, Contact for '${message.body}' - ${contact?.phones.map((e) => e.number.toString()).join(', ') ?? 'Not Found'}");
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final Telephony telephony = Telephony.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(initializeTelephony);
//   }
//
//   Future<void> initializeTelephony() async {
//
//
//     bool contactPermissionsGranted =   await Permission.contacts.request().isGranted;
//     if(!contactPermissionsGranted){
//       return;
//     }
//
//     bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
//
//     if(!(permissionsGranted ?? true)){
//       return;
//     }
//
//
//
//
//     log('jahsvck');
//
//     telephony.listenIncomingSms(
//         onNewMessage: (SmsMessage message) async {
//
//           log(message.toString());
//           log(message.body.toString());
//           Vibration.vibrate(duration: 1000);
//
//           List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
//
//           log(contacts.toString());
//
//           Contact? contact;
//           for (var element in contacts) {
//             log(element.toJson().toString());
//             if(element.displayName.contains(message.body ?? 'Not Found')){
//               contact = element;
//             }
//           }
//
//           await Telephony.instance.sendSms(to: "8714359066", message: "Message from foreground, Contact for '${message.body}' - ${contact?.phones.map((e) => e.number.toString()).join(', ') ?? 'Not Found'}");
//         },
//         onBackgroundMessage: backgroundMessageHandler
//     );
//   }
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(
    MultiProvider(
      providers: MultiProviders.providers,
      child: const MyApp(),
    ),
  );
}

Future<void> _initialize() async {
  await Hive.initFlutter();
  HiveAdapter.register();
  await configureInjection();
  await _initializeConfig();
}

Future<void> _initializeConfig() async {
  await locator<SettingsRepository>().initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = locator<AppRouter>();

    return OverlaySupport.global(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'My Helper',
          routerConfig: appRouter.config(),
          theme: ThemeData(
            expansionTileTheme: const ExpansionTileThemeData(
                // collapsedIconColor: ThemeColors.white,
                // iconColor: ThemeColors.white,
                ),
            dialogTheme: const DialogTheme(
              surfaceTintColor: Colors.transparent,
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.transparent,
            ),
            // scaffoldBackgroundColor: ThemeColors.primaryBg,
            // colorScheme: ColorScheme.fromSwatch(primarySwatch: ThemeColors.primaryMaterial),
            useMaterial3: true,
            // fontFamily: ThemeTextStyle.supreme,
          ),
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);

            return MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
