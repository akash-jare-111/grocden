// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:velocity_x/velocity_x.dart';
// import '../models/product_model.dart';
// import '../widgets/app_header.dart';
// import '../widgets/lists/product_list.dart';
//
//
// class HomeTab extends StatefulWidget{
//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab> {
//
//   loadData() async {
//
//     await Future.delayed(Duration(seconds: 5));
//     final productJson = await rootBundle.loadString("assets/files/product_data.json");
//     //print(catalogueJson);
//
//     final decodedData = jsonDecode(productJson);
//     //print(decodedData);
//
//     var productData = decodedData["products"];
//
//     ProductModel.products = List.from(productData).map<Product>((item) => Product.fromMap(item)).toList();
//     print(productData);
//
//     setState(() {});
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     loadData();
//   }
//
//   @override
//   Widget build(BuildContext context){
//
//     return Scaffold(
//         backgroundColor: Vx.green400,
//         floatingActionButton: Container(
//           height: 75,
//           width: 75,
//           child: FloatingActionButton(
//             backgroundColor: Color(0xff403b58),
//             onPressed: (){
//               //Navigator.pushNamed(context, 'CartPage');
//             },
//             child: Icon(CupertinoIcons.cart,size: 45,),
//
//           ),
//         ),
//         body : SafeArea(
//           child: Container(
//             padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppHeader(),
//                 if(ProductModel.products!=null && ProductModel.products.isNotEmpty)
//                   ProductList()
//                       .pOnly(top: 16)
//                       .expand()
//                 else
//                   CircularProgressIndicator().centered().expand(),
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }























import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import '../models/product_model.dart';
import '../widgets/app_header.dart';
import '../widgets/lists/product_list.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  loadData() async {
    await Future.delayed(Duration(seconds: 5));
    final productJson = await rootBundle.loadString("assets/files/product_data.json");
    final decodedData = jsonDecode(productJson);
    var productData = decodedData["products"];
    ProductModel.products = List.from(productData).map<Product>((item) => Product.fromMap(item)).toList();
    setState(() {
      _filteredProducts = ProductModel.products;
    });
  }

  void filterProducts(String searchQuery) {
    setState(() {
      _filteredProducts = ProductModel.products
          .where((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.green300,
      floatingActionButton: Container(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          child: Icon(CupertinoIcons.cart, size: 40),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(),
              HeightBox(10),
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  filterProducts(value);
                },
                decoration: InputDecoration(
                  //labelText: 'Search Products',
                  hintText: 'Search Products',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              if (_filteredProducts.isNotEmpty)
                ProductList(products: _filteredProducts)
                    .pOnly(top: 16)
                    .expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
