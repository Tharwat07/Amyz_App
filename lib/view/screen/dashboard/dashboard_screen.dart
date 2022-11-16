import 'package:amyz_user_app/view/screen/home/widget/category_view.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../helper/network_info.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/images.dart';
import '../category/all_category_screen.dart';
import '../chat/inbox_screen.dart';
import '../home/home_screen.dart';
import '../more/more_screen.dart';
import '../notification/notification_screen.dart';
import '../order/order_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;

  List<Widget> _screens;

  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;

  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .businessMode ==
        "single";

    _screens = [
      HomePage(),
      singleVendor
          ? OrderScreen(isBacButtonExist: false)
          : AllCategoryScreen(),
      singleVendor
          ? NotificationScreen(isBacButtonExist: false)
          : OrderScreen(isBacButtonExist: false),
      singleVendor ? MoreScreen() : NotificationScreen(isBacButtonExist: false),
      singleVendor ? SizedBox() : MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyText1.color,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor),
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == _pageIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
        height: 25,
        width: 25,
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];
    _list.add(_barItem(Images.home_image, getTranslated('home', context), 0));
    if (!isSingleVendor) {
      _list.add(
          _barItem(Images.more_filled_image, getTranslated('CATEGORY', context), 1));
    }
    _list.add(
        _barItem(Images.shopping_image, getTranslated('orders', context), 2));
    _list.add(_barItem(
        Images.notification, getTranslated('notification', context), 3));
    _list.add(_barItem(Images.more_image, getTranslated('more', context), 4));
    return _list;
  }
}
