import 'dart:developer';

import 'package:e_commerce_application/ui/categoryProductsPage.dart';
import 'package:e_commerce_application/ui/drawerWidget.dart';
import 'package:e_commerce_application/ui/productDetailsPage.dart';
import 'package:e_commerce_application/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        title: const Text("E - commerce"),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Category",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    log("length ==" + snapshot.data!.length.toString());
                    return SizedBox(
                      height: 80,
                      //  color: Colors.amber,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            // 13,
                            snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                log("clicked");

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CategoryProductsPage(
                                      //  catid: ,catname: ,
                                      catid: snapshot.data![index].id,
                                      catname: snapshot.data![index].category,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(37, 5, 2, 39),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category,
                                    // "Cateogry name",
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Offer Products",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),

            //view products
            Expanded(
              child: FutureBuilder(
                  future: Webservice().fetchOfferProducts(),
                  builder: (context, snapshot) {
                    //  log("product length ==" + snapshot.data!.length.toString());
                    if (snapshot.hasData) {
                      return Container(
                        // color: Colors.amber,
                        child: StaggeredGridView.countBuilder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                //  14,
                                snapshot.data!.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final product = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                  log("clicked");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsPage(
                                          id: product.id!,
                                          name: product.productname!,
                                          image: Webservice().imageurl +
                                              product.image!,
                                          price: product.price.toString(),
                                          description: product.description!);
                                    },
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 100, maxHeight: 250),
                                            child: Image(
                                                image: NetworkImage(
                                              Webservice().imageurl +
                                                  product.image!,
                                               )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  product.productname!,
                                                  //  "Shoes ssssssssssssssssssssssssssssssss",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rs. ' +
                                                      product.price.toString(),
                                                  //  "2000",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                 StaggeredTile.fit(1)),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),

            //closing
          ],
        ),
      ),
    );
  }
}