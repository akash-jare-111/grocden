import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/shop_model.dart';
import '../widgets/lists/shops_list.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopTab extends StatefulWidget {
  const ShopTab({super.key});

  @override
  State<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {

  loadData() async {

    await Future.delayed(Duration(seconds: 5));
    final catalogueJson = await rootBundle.loadString("assets/files/shop_data.json");
    //print(catalogueJson);

    final decodedData = jsonDecode(catalogueJson);
    //print(decodedData);

    var productData = decodedData["shoplist"];

    ShopModel.shops = List.from(productData).map<Shop>((item) => Shop.fromMap(item)).toList();
    //print(productData);

    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Shops"),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //CatalogueHeader(),
              if(ShopModel.shops!=null && ShopModel.shops.isNotEmpty)
                ShopList()
                    .py8()
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
