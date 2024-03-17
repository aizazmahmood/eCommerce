import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/HomeController.dart';
import 'package:pointofsale/views/CategoryScreen/ItemDetails.dart';
import 'package:pointofsale/views/HomeScreen/SearchScreen.dart';
import 'package:pointofsale/views/HomeScreen/components/Featured_Button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: lightGrey,
              height: 60,
              alignment: Alignment.center,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                          title: controller.searchController.text));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  hintStyle: const TextStyle(color: textFieldGrey),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // brand banners
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(sliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButton(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todayDeal : flashSale,
                              )),
                    ),

                    //second swiper
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButton(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth * 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategriz
                                    : index == 1
                                        ? brand
                                        : topSellers,
                              )),
                    ),

                    //featured categories
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategriz.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semiBold)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                  icon: featuredImages1[index],
                                  title: featuredTitles1[index]),
                              10.heightBox,
                              featuredButton(
                                  icon: featuredImages2[index],
                                  title: featuredTitles2[index]),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),

                    //featured products

                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                                stream: FirestoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredProducts = snapshot.data!.docs;
                                    return Row(
                                      children: [
                                        ...List.generate(
                                          featuredProducts.length,
                                          (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                featuredProducts[index]
                                                    ['p_images'][0],
                                                width: 130,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              ),
                                              10.heightBox,
                                              "${featuredProducts[index]['p_name']}"
                                                  .text
                                                  .fontFamily(semiBold)
                                                  .color(darkFontGrey)
                                                  .make(),
                                              10.heightBox,
                                              "${featuredProducts[index]['p_price']}"
                                                  .numCurrency
                                                  .text
                                                  .color(redColor)
                                                  .fontFamily(bold)
                                                  .size(16)
                                                  .make(),
                                            ],
                                          )
                                              .box
                                              .white
                                              .roundedSM
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .padding(const EdgeInsets.all(8))
                                              .make()
                                              .onTap(() {
                                            Get.to(() => ItemDetails(
                                                  title:
                                                      "${featuredProducts[index]['p_name']}",
                                                  data: featuredProducts[index],
                                                ));
                                          }),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),

                    //third swiper

                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    //all products
                    20.heightBox,

                    Align(
                      alignment: Alignment.centerLeft,
                      child: "All Products"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(18)
                          .make(),
                    ),
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allProductsData = snapshot.data!.docs;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allProductsData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allProductsData[index]['p_images'][0],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  "${allProductsData[index]['p_name']}"
                                      .text
                                      .fontFamily(semiBold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allProductsData[index][' p_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allProductsData[index]['p_name']}",
                                      data: allProductsData[index],
                                    ));
                              });
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
