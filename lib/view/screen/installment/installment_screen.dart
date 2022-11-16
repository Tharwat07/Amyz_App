import 'package:amyz_user_app/provider/localization_provider.dart';
import 'package:amyz_user_app/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/no_internet_screen.dart';

class InstallmentScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;

  InstallmentScreen({this.fromCheckout = false, this.sellerId = 1});

  @override
  State<InstallmentScreen> createState() => _InstallmentScreenState();
}

class _InstallmentScreenState extends State<InstallmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
                title: Provider.of<LocalizationProvider>(context).isLtr
                    ? 'Installment'
                    : 'تقسيط'),
            true
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.separated(
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Your request was sent'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              color: ColorResources.getRed(context),
                            ),
                          ),
                        ),
                      ),
                      itemCount: 10,
                      separatorBuilder: (ctx, index) => SizedBox(
                        height: 5,
                      ),
                    ),
                  )
                : Expanded(
                    child: NoInternetOrDataScreen(isNoInternet: false),
                  ),
          ],
        ),
      ),
    );
  }
}
