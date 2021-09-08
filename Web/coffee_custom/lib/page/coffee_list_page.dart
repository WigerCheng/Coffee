import 'package:coffee_custom/pojo/ad.dart';
import 'package:coffee_custom/pojo/coffee.dart';
import 'package:coffee_custom/pojo/coffee_status.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/service/ad_service.dart';
import 'package:coffee_custom/service/coffee_service.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'coffee_item.dart';

class CoffeeListPage extends StatefulWidget {
  @override
  _CoffeeListPageState createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  Future<Result<List<AD>>> _adList = getBanners();

  Future<Result<List<Coffee>>> _coffeeList = getCoffeeList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                FutureBuilder<Result<List<AD>>>(
                  future: _adList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 400,
                        child: Swiper(
                          autoplay: true,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imageUrl(snapshot.data.data[index].bannerImg),
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: snapshot.data.data.length ?? 0,
                          pagination: new SwiperPagination(),
                          control: new SwiperControl(),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                FutureBuilder<Result<List<Coffee>>>(
                  future: _coffeeList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        alignment: WrapAlignment.start,
                        children: _buildCoffeeItems(snapshot.data.data),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<CoffeeItem> _buildCoffeeItems(List<Coffee> coffees) {
    return coffees
        .where((value) => value.coffeeStatus == ON_SOLD)
        .map((e) => CoffeeItem(e))
        .toList();
  }
}
