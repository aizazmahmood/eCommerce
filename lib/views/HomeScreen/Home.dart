import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/HomeController.dart';
import 'package:pointofsale/views/AccountScreen/AccountScreen.dart';
import 'package:pointofsale/views/CartScreen/CartScreen.dart';
import 'package:pointofsale/views/CategoryScreen/CategoryScreen.dart';
import 'package:pointofsale/views/HomeScreen/HomeScreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    var navBar = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categriz),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => ExitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semiBold),
            type: BottomNavigationBarType.fixed,
            items: navBar,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
