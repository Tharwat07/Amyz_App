import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/cart_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget({Key key, this.cartModel, @required this.index, @required this.fromCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor,

      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:  MainAxisAlignment.start,
          children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.20),width: 1)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder, height: 60, width: 60,
              image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}/${cartModel.thumbnail}',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,fit: BoxFit.cover, height: 60, width: 60),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(cartModel.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: titilliumBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          color: ColorResources.getReviewRattingColor(context),
                        )),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                      !fromCheckout ? InkWell(
                        onTap: () {
                          if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                            Provider.of<CartProvider>(context, listen: false).removeFromCartAPI(context,cartModel.id);
                          }else {
                            Provider.of<CartProvider>(context, listen: false).removeFromCart(index);
                          }
                        },
                        child: Container(width: 20,height: 20,
                            child: Image.asset(Images.delete,scale: .5,)),
                      ) : SizedBox.shrink(),
                    ],

                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  Row(
                    children: [

                      cartModel.discount>0?
                      Text(
                        PriceConverter.convertPrice(context, cartModel.price),maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: titilliumSemiBold.copyWith(color: ColorResources.getRed(context),
                            decoration: TextDecoration.lineThrough,
                        ),
                      ):SizedBox(),
                      SizedBox(width: Dimensions.FONT_SIZE_DEFAULT,),
                      Text(
                        PriceConverter.convertPrice(context, cartModel.price,
                            discount: cartModel.discount,discountType: 'amount'),
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: titilliumRegular.copyWith(
                            color: ColorResources.getPrimary(context),

                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                            ),
                      ),
                    ],
                  ),


                  //variation
                  (cartModel.variant != null && cartModel.variant.isNotEmpty) ? Padding(
                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(children: [
                      //Text('${getTranslated('variations', context)}: ', style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                      Flexible(child: Text(cartModel.variant, 
                          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            color: ColorResources.getReviewRattingColor(context),))),
                    ]),
                  ) : SizedBox(),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    cartModel.shippingType !='order_wise' && Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(children: [
                        Text('${getTranslated('shipping_cost', context)}: ',
                            style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: ColorResources.getReviewRattingColor(context))),
                        Text('${cartModel.shippingCost}', style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor,)),
                      ]),
                    ):SizedBox(),



                    Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                          child: QuantityButton(isIncrement: false, index: index, quantity: cartModel.quantity,maxQty: 20,cartModel: cartModel),
                        ),
                        Text(cartModel.quantity.toString(), style: titilliumSemiBold),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          child: QuantityButton(index: index, isIncrement: true, quantity: cartModel.quantity, maxQty: 20, cartModel: cartModel),
                        ),
                      ],
                    ) : SizedBox.shrink(),
                  ],),

                ],
              ),
          ),
        ),



      ]),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final CartModel cartModel;
  final bool isIncrement;
  final int quantity;
  final int index;
  final int maxQty;
  QuantityButton({@required this.isIncrement, @required this.quantity, @required this.index, @required this.maxQty,@required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          // Provider.of<CartProvider>(context, listen: false).setQuantity(false, index);
          Provider.of<CartProvider>(context, listen: false).updateCartProductQuantity(cartModel.id,cartModel.quantity-1, context).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value.message), backgroundColor: value.isSuccess ? Colors.green : Colors.red,
            ));
          });
        } else if (isIncrement && quantity < maxQty) {
          // Provider.of<CartProvider>(context, listen: false).setQuantity(true, index);
          Provider.of<CartProvider>(context, listen: false).updateCartProductQuantity(cartModel.id, cartModel.quantity+1, context).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value.message), backgroundColor: value.isSuccess ? Colors.green : Colors.red,
            ));
          });
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? quantity >= maxQty ? ColorResources.getGrey(context)
            : ColorResources.getPrimary(context)
            : quantity > 1
            ? ColorResources.getPrimary(context)
            : ColorResources.getGrey(context),
        size: 30,
      ),
    );
  }
}

