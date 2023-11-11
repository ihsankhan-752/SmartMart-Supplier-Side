import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class FilterAll extends StatefulWidget {
  const FilterAll({Key? key}) : super(key: key);

  @override
  State<FilterAll> createState() => _FilterAllState();
}

class _FilterAllState extends State<FilterAll> {
  var rangeValue = RangeValues(0, 5000000);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Popularity'),
              subtitle: Text(
                'No Setting',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              children: [Text('helooo'), Text('helooo'), Text('helooo'), Text('helooo')],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Brands'),
              subtitle: Text(
                'Armani, Adidas, Gucci',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              children: [Text('helooo'), Text('helooo'), Text('helooo'), Text('helooo')],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Price'),
              children: [Text('helooo'), Text('helooo'), Text('helooo'), Text('helooo')],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Color'),
              subtitle: Text(
                'Black, Red, Grey, White',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              children: [
                Container(
                  height: 200,
                  child: RangeSlider(
                    min: 0,
                    max: 5000000,
                    labels: RangeLabels(
                      'R\$ ${rangeValue.start.round()}',
                      'R\$ ${rangeValue.end.round()}',
                    ),
                    values: rangeValue,
                    inactiveColor: AppColors.lightGrey,
                    activeColor: AppColors.lightGrey,
                    onChanged: (v) {
                      setState(() {
                        rangeValue = v;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Rating'),
              subtitle: Text(
                '4 Star',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              children: [Text('helooo'), Text('helooo'), Text('helooo'), Text('helooo')],
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Text('Shipped From'),
              subtitle: Text(
                'No Setting',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              children: [Text('helooo'), Text('helooo'), Text('helooo'), Text('helooo')],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red, width: 1.5)),
                  child: Center(
                      child: Text(
                    'Clear',
                  )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text('Apply', style: AppTextStyles().subHeading.copyWith(color: AppColors.primaryWhite))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
