import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class ProductCardListWidget extends StatelessWidget {
  Product products;
  Color? backgroundColor;
  VoidCallback? onTapImage;
  ProductCardListWidget({super.key, required this.products, this.onTapImage, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    int addToCart = 0;
    return Container(
      height: 300,
      margin: EdgeInsets.all(16),
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.red,
                ),
                child: Text(
                  "-${products.discountPercentage.toString()}%",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              ),
              Container(
                child: Icon(
                  Icons.favorite_border,
                  size: 25,
                ),
                padding: EdgeInsets.only(right: 10),
              )
            ],
          ),
          Expanded(
            child: Image.network(
              products.thumbnail ?? "",
              fit: BoxFit.cover,
              height: 120,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
                ),
                  child: Image.network(
                products.meta?.qrCode ?? "",
                height: 40,
              )),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8),
          //   child: Text(
          //     products.title ?? "",
          //     style: TextStyle(fontSize: 12),
          //     maxLines: 1, // Limits to 1 line
          //     overflow: TextOverflow
          //         .ellipsis, // Shows "..." if the text overflows
          //     softWrap: false, // Prevents wrapping to a new line
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "\$ ${products.price}",
          //         style: TextStyle(
          //             color: Colors.red, fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         "Views: ${products.reviews!.length}",
          //         style: TextStyle(
          //             color: Colors.amberAccent,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 10),
          //       )
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: Colors.grey, // Line color
          //   thickness: 1, // Right spacing (optional)
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InkWell(
          //         onTap: (){
          //           // setState(() {
          //           //   if(addToCart>0){
          //           //     addToCart--;
          //           //   }
          //           // });
          //         },
          //         child: Icon(
          //           Icons.remove,
          //           color: Colors.red,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Icon(
          //             Icons.shopping_cart,
          //             color: Colors.grey,
          //             size: 15,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Text(
          //             addToCart.toString(),
          //             style:
          //             TextStyle(fontSize: 15, color: Colors.grey),
          //           )
          //         ],
          //       ),
          //       InkWell(
          //         onTap: (){
          //           // setState(() {
          //           //   addToCart++;
          //           // });
          //         },
          //         child: Icon(
          //           Icons.add,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
