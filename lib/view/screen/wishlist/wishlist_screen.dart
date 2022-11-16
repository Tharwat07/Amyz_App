import 'package:amyz_user_app/view/screen/wishlist/widget/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/localization_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../utill/color_resources.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/not_loggedin_widget.dart';

class WishListScreen extends StatefulWidget {
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  bool isGuestMode;

  @override
  void initState() {
    super.initState();
    isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('wishList', context)),

          Expanded(
            child: isGuestMode ? NotLoggedInWidget() :  Consumer<WishListProvider>(
              builder: (context, wishListProvider, child) {
                return wishListProvider.wishList != null ? wishListProvider.wishList.length > 0 ? RefreshIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    await  Provider.of<WishListProvider>(context, listen: false).initWishList(
                      context, Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode,
                    );
                  },

                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: wishListProvider.wishList.length,
                    itemBuilder: (context, index) => WishListWidget(
                      product: wishListProvider.wishList[index],
                      index: index,
                    ),
                  ),
                ) : NoInternetOrDataScreen(isNoInternet: false): WishListShimmer();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WishListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<WishListProvider>(context).wishList==null,
          child: ListTile(
            leading: Container(height: 50, width: 50, color: ColorResources.WHITE),
            title: Container(height: 20, color: ColorResources.WHITE),
            subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(height: 10, width: 70, color: ColorResources.WHITE),
              Container(height: 10, width: 20, color: ColorResources.WHITE),
              Container(height: 10, width: 50, color: ColorResources.WHITE),
            ]),
            trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(height: 15, width: 15, decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.WHITE)),
              SizedBox(height: 10),
              Container(height: 10, width: 50, color: ColorResources.WHITE),
            ]),
          ),
        );
      },
    );
  }
}
