import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:june_lake/model/entry.dart';
import 'package:provider/provider.dart';

class Swiper extends StatelessWidget {
  Widget _builder(BuildContext context, int index) {
    var dates = Provider.of<List<Entry>>(context);
    var datesMap = {};
    dates.forEach((e) => datesMap[e.creationDate] = e);
    print(datesMap);
    if (datesMap == null) return Text('loading');
    var now = DateTime.now();
    var date = DateTime(now.year, now.month, index + 1);

    if (datesMap.containsKey(date))
      return Container(
        child: Text(datesMap[date].content),
      );

    return Container(
        child: Column(children: [
      Text('(${index + 1}/29) no content'),
      RaisedButton(
        child: Text('create!'),
        onPressed: () {},
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(itemCount: 29, itemBuilder: _builder);
  }
}
