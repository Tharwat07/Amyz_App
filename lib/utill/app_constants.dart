
import '../data/model/response/language_model.dart';

class AppConstants {
  static const String APP_NAME = 'Amyz';
  static const String BASE_URL = 'BaseURL';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static const String CATEGORIES_URI = 'API/categories';
  static const String BRANDS_URI = 'API/brands';
  static const String BRAND_PRODUCT_URI = 'API/brands/products/';
  static const String CATEGORY_PRODUCT_URI = 'API/categories/products/';
  static const String REGISTRATION_URI = 'API/auth/register';
  static const String LOGIN_URI = 'API/auth/login';
  static const String LATEST_PRODUCTS_URI = 'API/products/latest?limit=10&&offset=';
  static const String NEW_ARRIVAL_PRODUCTS_URI = 'API/products/latest?limit=10&&offset=';
  static const String TOP_PRODUCTS_URI = 'API/products/top-rated?limit=10&&offset=';
  static const String BEST_SELLING_PRODUCTS_URI = 'API/products/best-sellings?limit=1&offset=';
  static const String DISCOUNTED_PRODUCTS_URI = 'API/products/discounted-product?limit=10&&offset=';
  static const String FEATURED_PRODUCTS_URI = 'API/products/featured?limit=10&&offset=';
  static const String HOME_CATEGORY_PRODUCTS_URI = 'API/products/home-categories';
  static const String PRODUCT_DETAILS_URI = 'API/products/details/';
  static const String PRODUCT_REVIEW_URI = 'API/products/reviews/';
  static const String SEARCH_URI = 'API/products/search?name=';
  static const String CONFIG_URI = 'API/config';
  static const String ADD_WISH_LIST_URI = 'API/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI = 'API/customer/wish-list/remove?product_id=';
  static const String UPDATE_PROFILE_URI = 'API/customer/update-profile';
  static const String CUSTOMER_URI = 'API/customer/info';
  static const String ADDRESS_LIST_URI = 'API/customer/address/list';
  static const String ADDRESS_CITY_URI = 'API/customer/address/cities';

  static const String REMOVE_ADDRESS_URI = 'API/customer/address?address_id=';
  static const String ADD_ADDRESS_URI = 'API/customer/address/add';
  static const String WISH_LIST_GET_URI = 'API/customer/wish-list';
  static const String SUPPORT_TICKET_URI = 'API/customer/support-ticket/create';
  static const String MAIN_BANNER_URI = 'API/banners?banner_type=main_banner';
  static const String FOOTER_BANNER_URI = 'API/banners?banner_type=footer_banner';
  static const String MAIN_SECTION_BANNER_URI = 'API/banners?banner_type=main_section_banner';
  static const String RELATED_PRODUCT_URI = 'API/products/related-products/';
  static const String ORDER_URI = 'API/customer/order/list';
  static const String ORDER_DETAILS_URI = 'API/customer/order/details?order_id=';
  static const String ORDER_PLACE_URI = 'API/customer/order/place';
  static const String SELLER_URI = 'API/seller?seller_id=';
  static const String SELLER_PRODUCT_URI = 'API/seller/';
  static const String TOP_SELLER = 'API/seller/top';
  static const String TRACKING_URI = 'API/order/track?order_id=';
  static const String FORGET_PASSWORD_URI = 'API/auth/forgot-password';
  static const String SUPPORT_TICKET_GET_URI = 'API/customer/support-ticket/get';
  static const String SUPPORT_TICKET_CONV_URI = 'API/customer/support-ticket/conv/';
  static const String SUPPORT_TICKET_REPLY_URI = 'API/customer/support-ticket/reply/';
  static const String SUBMIT_REVIEW_URI = 'API/products/reviews/submit';
  static const String FLASH_DEAL_URI = 'API/flash-deals';
  static const String FEATURED_DEAL_URI = 'API/deals/featured';
  static const String FLASH_DEAL_PRODUCT_URI = 'API/flash-deals/products/';
  static const String COUNTER_URI = 'API/products/counter/';
  static const String SOCIAL_LINK_URI = 'API/products/social-share-link/';
  static const String SHIPPING_URI = 'API/products/shipping-methods';
  static const String CHOSEN_SHIPPING_URI = 'API/shipping-method/chosen';
  static const String COUPON_URI = 'API/coupon/apply?code=';
  static const String MESSAGES_URI = 'API/customer/chat/messages?shop_id=';
  static const String CHAT_INFO_URI = 'API/customer/chat';
  static const String SEND_MESSAGE_URI = 'API/customer/chat/send-message';
  static const String TOKEN_URI = 'API/customer/cm-firebase-token';
  static const String NOTIFICATION_URI = 'API/notifications';
  static const String GET_CART_DATA_URI = 'API/cart';
  static const String ADD_TO_CART_URI = 'API/cart/add';
  static const String UPDATE_CART_QUANTITY_URI = 'API/cart/update';
  static const String REMOVE_FROM_CART_URI = 'API/cart/remove';
  static const String GET_SHIPPING_METHOD = 'API/shipping-method/by-seller';
  static const String CHOOSE_SHIPPING_METHOD = 'API/shipping-method/choose-for-order';
  static const String CHOSEN_SHIPPING_METHOD_URI = 'API/shipping-method/chosen';
  static const String GET_SHIPPING_INFO = 'API/shipping-method/detail/1';
  static const String CHECK_PHONE_URI = 'API/auth/check-phone';
  static const String VERIFY_PHONE_URI = 'API/auth/verify-phone';
  static const String SOCIAL_LOGIN_URI = 'API/auth/social-login';
  static const String CHECK_EMAIL_URI = 'API/auth/check-email';
  static const String VERIFY_EMAIL_URI = 'API/auth/verify-email';
  static const String RESET_PASSWORD_URI = 'API/auth/reset-password';
  static const String VERIFY_OTP_URI = 'API/auth/verify-otp';
  static const String REFUND_REQUEST_URI = 'API/customer/order/refund-store';
  static const String REFUND_REQUEST_PRE_REQ_URI = 'API/customer/order/refund';
  static const String REFUND_RESULT_URI = 'API/customer/order/refund-details';
  static const String CANCEL_ORDER_URI = 'API/order/cancel-order';
  static const String GET_SELECTED_SHIPPING_TYPE_URI = 'API/shipping-method/check-shipping-type';
  static const String DEAL_OF_THE_DAY_URI = 'API/dealsoftheday/deal-of-the-day';

  //address
  static const String UPDATE_ADDRESS_URI = 'API/customer/address/update/';
  static const String GEOCODE_URI = 'API/mapapi/geocode-api';
  static const String SEARCH_LOCATION_URI = 'API/mapapi/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = 'API/mapapi/place-api-details';
  static const String DISTANCE_MATRIX_URI = 'API/mapapi/distance-api';


  // sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String LANG_KEY = 'lang';
  static const String INTRO = 'intro';

  // order status
  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'canceled';
  static const String OUT_FOR_DELIVERY = 'out_for_delivery';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';
  static const String TOPIC = 'sixvalley';
  static const String USER_ADDRESS = 'user_address';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
