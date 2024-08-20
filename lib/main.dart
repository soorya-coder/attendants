
import '../constants/functions.dart';
import '../constants/wigets.dart';
import '../screen/class.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import '../screen/today.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screen/profile.dart';
import 'service/authHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(250, 500),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => GetUser(),
              '/home': (context) => const Home(),
              '/today': (context) => const Today(),
              '/class': (context) => const Class(),
              '/profile': (context) => const Profile(),
              '/addclass': (context) => const Add_class(),
              //'/': (context) => (),
            },
            theme: ThemeData(
              textTheme: GoogleFonts.rubikTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class GetUser extends StatelessWidget {
  GetUser({Key? key}) : super(key: key);
  AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authHelper.authchanges(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            AuthHelper().addlogins();
            return const Today();
          } else {
            return const Login();
          }
        }
        if (snapshot.hasError) {
          return Errored(error: '${snapshot.error}2');
        }
        return const Spalsh();
      },
    );
  }
}

class _SpalshState extends State<Spalsh> {
  @override
  void initState() {
    super.initState();
    mainscreen();
  }

  void mainscreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    inrout = (pref.getInt('inrout') ?? 0);
    pname = (pref.getString('pname') ?? '');
    pinstut = (pref.getString('pinstution') ?? '');
    pemail = (pref.getString('pemail') ?? '');
    Future.delayed(const Duration(seconds: 4), () async {
      if (pname == '' || pemail == '' || pinstut == '') {
        route(context, const Login());
      } else {
        route(context, screens[inrout]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.redAccent.withOpacity(0.5),
              Colors.lightGreen.withOpacity(0.5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (boulds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightGreen.withOpacity(0.8),
                    Colors.redAccent.withOpacity(0.8),
                  ],
                ).createShader(boulds),
                child: const Icon(
                  CupertinoIcons.doc_append,
                  size: 100,
                ),
              ),
              hspace(20),
              Text(
                'Attendants',
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  color: CupertinoColors.white,
                ),
              ),
              const Spacer(),
              const LinearProgressIndicator(
                minHeight: 10,
                backgroundColor: CupertinoColors.white,
                color: Colors.lightGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route nextpage(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
              Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.brown.withOpacity(0.7),
          child: LoadingAnimationWidget.halfTriangleDot(
              color: Colors.white, size: 50),
        ),
      ),
    );
  }
}

class Errored extends StatelessWidget {
  Errored({Key? key, required this.error}) : super(key: key);
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.brown.shade100.withOpacity(0.7),
        child: Center(
          child: Text(
            'error :$error',
            style: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}

class Inform extends StatelessWidget {
  Inform({Key? key, required this.info}) : super(key: key);
  String info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.brown.withOpacity(0.7),
        child: Center(
          child: Text(
            info,
            style: TextStyle(color: Colors.amber.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}

class Spalsh extends StatefulWidget {
  const Spalsh({super.key});

  @override
  _SpalshState createState() => _SpalshState();
}

