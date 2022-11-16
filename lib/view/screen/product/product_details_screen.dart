import 'package:amyz_user_app/view/screen/product/widget/bottom_cart_view.dart';
import 'package:amyz_user_app/view/screen/product/widget/product_image_view.dart';
import 'package:amyz_user_app/view/screen/product/widget/product_specification_view.dart';
import 'package:amyz_user_app/view/screen/product/widget/product_title_view.dart';
import 'package:amyz_user_app/view/screen/product/widget/promise_screen.dart';
import 'package:amyz_user_app/view/screen/product/widget/related_product_view.dart';
import 'package:amyz_user_app/view/screen/product/widget/review_widget.dart';
import 'package:amyz_user_app/view/screen/product/widget/seller_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/product_model.dart';
import '../../../helper/product_type.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/product_details_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/rating_bar.dart';
import '../../basewidget/title_row.dart';
import '../home/widget/products_view.dart';
import 'faq_and_review_screen.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails({
    @required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  _loadData(BuildContext context) async {
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .removePrevReview();
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .initProduct(widget.product, context);
    Provider.of<ProductProvider>(context, listen: false)
        .removePrevRelatedProduct();
    Provider.of<ProductProvider>(context, listen: false)
        .initRelatedProductList(widget.product.id.toString(), context);
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .getCount(widget.product.id.toString(), context);
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .getSharableLink(widget.product.slug.toString(), context);
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<WishListProvider>(context, listen: false)
          .checkWishList(widget.product.id.toString(), context);
    }
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(widget.product.userId.toString(), 1, context);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    String ratting =
        widget.product.rating != null && widget.product.rating.length != 0
            ? widget.product.rating[0].average.toString()
            : "0";
    _loadData(context);
    return Consumer<ProductDetailsProvider>(
      builder: (context, details, child) {
        return details.hasConnection
            ? Scaffold(
                backgroundColor: Theme.of(context).cardColor,
                appBar: AppBar(
                  title: Row(children: [
                    Container(
                      height: 35,
                      width: 50,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: InkWell(
                        child: Image.asset(
                          "assets/images/arrow_back.png",
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text(
                      getTranslated('product_details', context),
                      style: robotoRegular.copyWith(
                        fontSize: 20,
                        color: Provider.of<ThemeProvider>(context).darkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ]),
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
                      ? Colors.black
                      : Theme.of(context).primaryColor,
                ),
                bottomNavigationBar: BottomCartView(product: widget.product),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      widget.product != null
                          ? ProductImageView(productModel: widget.product)
                          : SizedBox(),
                      Container(
                        transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                        padding:
                            EdgeInsets.only(top: Dimensions.FONT_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              topRight: Radius.circular(
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE)),
                        ),
                        child: Column(
                          children: [
                            ProductTitleView(productModel: widget.product),

                            // Specification
                            (widget.product.details != null &&
                                    widget.product.details.isNotEmpty)
                                ? Container(
                                    height: 158,
                                    margin: EdgeInsets.only(
                                        top: Dimensions.PADDING_SIZE_SMALL),
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: ProductSpecification(
                                        productSpecification:
                                            widget.product.details ?? ''),
                                  )
                                : SizedBox(),

                            //promise
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                                    horizontal: Dimensions.FONT_SIZE_DEFAULT),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor),
                                child: PromiseScreen()),

                            widget.product.addedBy == 'seller'
                                ? SellerView(
                                    sellerId: widget.product.userId.toString())
                                : SizedBox.shrink(),
                            //widget.product.addedBy == 'admin' ? SellerView(sellerId: '0') : SizedBox.shrink(),

                            // Reviews
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_SMALL),
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              color: Theme.of(context).cardColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getTranslated(
                                          'customer_reviews', context),
                                      style: titilliumSemiBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_LARGE),
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    Container(
                                      width: 230,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            ColorResources.visitShop(context),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RatingBar(
                                            rating: double.parse(ratting),
                                            size: 18,
                                          ),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          Text('${double.parse(ratting).toStringAsFixed(1)}' +
                                              ' ' +
                                              '${getTranslated('out_of_5', context)}'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            Dimensions.PADDING_SIZE_DEFAULT),
                                    Text('${getTranslated('total', context)}' +
                                        ' ' +
                                        '${details.reviewList != null ? details.reviewList.length : 0}' +
                                        ' ' +
                                        '${getTranslated('reviews', context)}'),
                                    details.reviewList != null
                                        ? details.reviewList.length != 0
                                            ? ReviewWidget(
                                                reviewModel:
                                                    details.reviewList[0])
                                            : SizedBox()
                                        : ReviewShimmer(),
                                    details.reviewList != null
                                        ? details.reviewList.length > 1
                                            ? ReviewWidget(
                                                reviewModel:
                                                    details.reviewList[1])
                                            : SizedBox()
                                        : ReviewShimmer(),
                                    details.reviewList != null
                                        ? details.reviewList.length > 2
                                            ? ReviewWidget(
                                                reviewModel:
                                                    details.reviewList[2])
                                            : SizedBox()
                                        : ReviewShimmer(),
                                    InkWell(
                                        onTap: () {
                                          if (details.reviewList != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ReviewScreen(
                                                            reviewList: details
                                                                .reviewList)));
                                          }
                                        },
                                        child: details.reviewList != null &&
                                                details.reviewList.length > 3
                                            ? Text(
                                                getTranslated(
                                                    'view_more', context),
                                                style:
                                                    titilliumRegular.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              )
                                            : SizedBox())
                                  ]),
                            ),

                            //saller more product
                            widget.product.addedBy == 'seller'
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                    child: TitleRow(
                                        title: getTranslated(
                                            'more_from_the_shop', context),
                                        isDetailsPage: true),
                                  )
                                : SizedBox(),

                            widget.product.addedBy == 'seller'
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: ProductView(
                                        isHomePage: false,
                                        productType: ProductType.SELLER_PRODUCT,
                                        scrollController: _scrollController,
                                        sellerId:
                                            widget.product.userId.toString()),
                                  )
                                : SizedBox(),

                            // Related Products
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_SMALL),
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                        vertical: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: TitleRow(
                                        title: getTranslated(
                                            'related_products', context),
                                        isDetailsPage: true),
                                  ),
                                  SizedBox(height: 5),
                                  RelatedProductView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(
                body: NoInternetOrDataScreen(
                  isNoInternet: true,
                  child: ProductDetails(
                    product: widget.product,
                  ),
                ),
              );
      },
    );
  }
}
