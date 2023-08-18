import 'package:flutter/material.dart';
import '../../models/shop_model.dart';
import '../../pages/order_by_list_page.dart';
import '../tiles/shops_tile.dart';

class ShopList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ShopModel.shops.length,
      itemBuilder: (context,index){
        final shop = ShopModel.shops[index];

        //infinite list
        //final shop = ShopModel.shops[index%ShopModel.shops.length];
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>
                        OrderByListPage(shop : shop)
                )
            ),
            child: ShopTile(shop : shop)
        );
      },
    );
  }
}

