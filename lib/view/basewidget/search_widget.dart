import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/search_provider.dart';
import '../../provider/theme_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final Function onTextChanged;
  final Function onClearPressed;
  final Function onSubmit;
  final bool isSeller;

  SearchWidget(
      {@required this.hintText,
      this.onTextChanged,
      @required this.onClearPressed,
      this.onSubmit,
      this.isSeller = false});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
        text: Provider.of<SearchProvider>(context).searchText);
    return Stack(children: [
      ClipRRect(
        child: Container(
          height: isSeller ? 50 : 80 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: isSeller ? 50 : 60,
          alignment: Alignment.center,
          child: Row(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                        bottomLeft: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                      topRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                      bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextFormField(
                    controller: _controller,
                    onFieldSubmitted: (query) {
                      onSubmit(query);
                    },
                    onChanged: (query) {
                      // onTextChanged(query);
                    },
                    textInputAction: TextInputAction.search,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: hintText,
                      isDense: true,
                      hintStyle: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor),
                      border: InputBorder.none,
                      //prefixIcon: Icon(Icons.search, color: ColorResources.getColombiaBlue(context), size: Dimensions.ICON_SIZE_DEFAULT),
                      suffixIcon: Provider.of<SearchProvider>(context)
                              .searchText
                              .isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.black),
                              onPressed: () {
                                onClearPressed();
                                _controller.clear();
                              },
                            )
                          : _controller.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear,
                                      color:
                                          ColorResources.getChatIcon(context)),
                                  onPressed: () {
                                    onClearPressed();
                                    _controller.clear();
                                  },
                                )
                              : null,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: () {
                Provider.of<SearchProvider>(context, listen: false)
                    .saveSearchAddress(_controller.text.toString());
                Provider.of<SearchProvider>(context, listen: false)
                    .searchProduct(_controller.text.toString(), context);
              },
              child: Container(
                width: 35,
                height: 35,
                color: Colors.transparent,
                child: Image.asset(
                  Images.search,
                  height: 0,
                  fit: BoxFit.contain,
                  color: Provider.of<ThemeProvider>(context).darkTheme
                      ? Colors.white38
                      : Colors.black45,
                ),

                // Icon(Icons.search, color: Theme.of(context).cardColor, size: Dimensions.ICON_SIZE_SMALL),
              ),
            ),
            SizedBox(width: 5),
          ]),
        ),
      ),
    ]);
  }
}
