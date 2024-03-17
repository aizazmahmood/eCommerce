import 'package:firebase_auth/firebase_auth.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/views/HomeScreen/Home.dart';
import 'package:pointofsale/views/auth_screen/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //a function here to control the changing of screen using getX
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //Get.to(()=>const AuthScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const AuthScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 200),
            ),
            20.heightBox,
            appLogo(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.fontFamily(semiBold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
