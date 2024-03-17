import 'package:pointofsale/consts/consts.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var userName = "";

  var featuredList = [];

  var searchController = TextEditingController();


  getUserName() async {
   var n = await fireStore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['Name'];
      }
    });

   userName = n;

  }
}