import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Controller/product_controller.dart';
import 'package:appshopthoitran/Views/widgets_common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../services/firestore_services.dart';
import '../widgets_common/loading_indicator.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title)) {
      productMethod = FirestorServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestorServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subCat.length,
                  (index) => controller.subCat[index].text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(120, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subCat[index]}");
                        setState(() {});
                      })),
            ),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: Center(
                    child: loadingIndicator(),
                  )
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: "Không có sản phẩm tìm thấy"
                      .text
                      .color(darkFontGrey)
                      .makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;
                return Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_imgs'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']}.000₫"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                              10.heightBox,
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIffav(data[index]);
                            Get.to(
                              () => ItemDetails(
                                title: "${data[index]['p_name']}",
                                data: data[index],
                              ),
                            );
                          });
                        }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
