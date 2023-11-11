import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';
import 'filter_all.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        FontAwesomeIcons.barsStaggered,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                    Spacer(),
                    Text('Discover',
                        style: AppTextStyles().subHeading.copyWith(color: AppColors.Pink_COLOR, fontSize: 17)),
                    Spacer(),
                    Icon(
                      Icons.search,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
                  tabs: [Text('All'), Text('Women'), Text('Men'), Text('Best Seller')],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FilterAll(),
                      Text('hsdfsa'),
                      Text('helosdf'),
                      Text('dfgsd'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
