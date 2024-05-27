import 'dart:developer';

import 'package:e_commerce_application/ui/productDetailsPage.dart';
import 'package:e_commerce_application/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoryProductsPage extends StatefulWidget{
  final String catname;
  final int catid;

  const CategoryProductsPage({ required this.catid, required this.catname});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}
class _CategoryProductsPageState extends State<CategoryProductsPage>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.catname),
      ),
       body: FutureBuilder(
          future: Webservice().getCategoryProducts(widget.catid),
          builder: (context, snapshot) {
            // log("length ==" + snapshot.data!.length.toString());
            if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
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
                              image: Webservice().imageurl + product.image!,
                              price: product.price.toString(),
                              description: product.description!,
                            );
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
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
                                    Webservice().imageurl + product.image!,
                                  )
                                      //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUU3VWK2nTbvZRiUCORkJJ80S4JrCoCqoYQ&usqp=CAU"),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        product.productname!,

                                        ///  "Shoessssssssssssssssssssssssssssssssssggggggggggggggggggggggsssssssss",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Rs. ',
                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              //  "2000",
                                              product.price.toString(),

                                              style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
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
                      const StaggeredTile.fit(1));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        );
  }
}
