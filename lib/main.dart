import 'package:flumazon/common/widgets/tabs_page.dart';
import 'package:flumazon/constants/global_variables.dart';
import 'package:flumazon/features/admin/screens/admin_screen.dart';
import 'package:flumazon/features/auth/screens/auth_screen.dart';
import 'package:flumazon/features/auth/services/auth_service.dart';
import 'package:flumazon/providers/user_provider.dart';
import 'package:flumazon/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 7.20

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flumazon',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
        home: (user.token ?? '').isNotEmpty
            ? (user.type == 'user')
                ? const TabsPage()
                : const AdminScreen()
            : const AuthScreen());
  }
}
