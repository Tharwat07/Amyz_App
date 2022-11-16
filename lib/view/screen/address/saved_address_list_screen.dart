import 'package:amyz_user_app/provider/theme_provider.dart';
import 'package:amyz_user_app/view/screen/address/widget/address_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/no_internet_screen.dart';
import 'add_new_address_screen.dart';
class SavedAddressListScreen extends StatelessWidget {
  const SavedAddressListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddNewAddressScreen(isBilling: false))),
        child: Icon(Icons.add, color: Theme.of(context).highlightColor),
        backgroundColor: ColorResources.getPrimary(context),
      ),
      appBar: AppBar(title: Text(getTranslated('SHIPPING_ADDRESS_LIST', context),),backgroundColor: Provider.of<ThemeProvider>(context).darkTheme?Colors.black:Theme.of(context).primaryColor,),
      body: SafeArea(child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                profile.addressList != null ? profile.addressList.length != 0 ?  SizedBox(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profile.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                        Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.getIconBg(context),
                              border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                            ),
                            child: AddressListPage(address: profile.addressList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                )  : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                  child: NoInternetOrDataScreen(isNoInternet: false)
                ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
              ],
            ),
          );
        },
      )),
    );
  }
}
