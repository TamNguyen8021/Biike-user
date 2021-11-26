import 'package:bikes_user/app/bindings/bike_binding.dart';
import 'package:bikes_user/app/bindings/cho_now_settings_binding.dart';
import 'package:bikes_user/app/bindings/login_binding.dart';
import 'package:bikes_user/app/bindings/notification_binding.dart';
import 'package:bikes_user/app/bindings/open_page_bingding.dart';
import 'package:bikes_user/app/bindings/pathshare_binding.dart';
import 'package:bikes_user/app/bindings/station_binding.dart';
import 'package:bikes_user/app/bindings/trip_binding.dart';
import 'package:bikes_user/app/bindings/trip_details_binding.dart';
import 'package:bikes_user/app/bindings/user_binding.dart';
import 'package:bikes_user/app/bindings/view_point_binding.dart';
import 'package:bikes_user/app/bindings/view_user_binding.dart';
import 'package:bikes_user/app/bindings/add_bike_binding.dart';
import 'package:bikes_user/app/bindings/voucher_binding.dart';
import 'package:bikes_user/app/bindings/add_address_book_binding.dart';
import 'package:bikes_user/app/bindings/add_sos_number_binding.dart';
import 'package:bikes_user/app/bindings/address_book_binding.dart';
import 'package:bikes_user/app/bindings/app_setting_binding.dart';
import 'package:bikes_user/app/bindings/ban_list_binding.dart';
import 'package:bikes_user/app/bindings/book_schedule_trip_binding.dart';
import 'package:bikes_user/app/bindings/book_trip_binding.dart';
import 'package:bikes_user/app/bindings/choose_mode_binding.dart';
import 'package:bikes_user/app/bindings/edit_address_book_binding.dart';
import 'package:bikes_user/app/bindings/edit_sos_number_binding.dart';
import 'package:bikes_user/app/bindings/register_binding.dart';
import 'package:bikes_user/app/bindings/sos_number_binding.dart';
import 'package:bikes_user/app/bindings/top_biker_binding.dart';
import 'package:bikes_user/app/bindings/trip_history_binding.dart';
import 'package:bikes_user/app/bindings/verify_phone_binding.dart';
import 'package:bikes_user/app/bindings/wallet_binding.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/add_address_book/add_address_book_page.dart';
import 'package:bikes_user/app/ui/android/pages/cho_now_settings/cho_now_settings_page.dart';
import 'package:bikes_user/app/ui/android/pages/home/require_add_bike_page.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/login_page.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/add_bike_page.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/add_bike_camera_page.dart';
import 'package:bikes_user/app/ui/android/pages/add_sos_number/add_sos_number_page.dart';
import 'package:bikes_user/app/ui/android/pages/address_book/address_book_page.dart';
import 'package:bikes_user/app/ui/android/pages/app_setting/app_setting_page.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/ban_list_page.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/book_schedule_trip_page.dart';
import 'package:bikes_user/app/ui/android/pages/book_trip/book_trip_page.dart';
import 'package:bikes_user/app/ui/android/pages/choose_mode/choose_mode_page.dart';
import 'package:bikes_user/app/ui/android/pages/edit_address_book/edit_address_book_page.dart';
import 'package:bikes_user/app/ui/android/pages/edit_profile/edit_profile_page.dart';
import 'package:bikes_user/app/ui/android/pages/edit_sos_number/edit_sos_number_page.dart';
import 'package:bikes_user/app/ui/android/pages/finding_biker/finding_biker_success_page.dart';
import 'package:bikes_user/app/ui/android/pages/notification/notification_page.dart';
import 'package:bikes_user/app/ui/android/pages/on_board/on_board_page.dart';
import 'package:bikes_user/app/ui/android/pages/trip_details/trip_details_full_map_page.dart';
import 'package:bikes_user/app/ui/android/pages/trip_details/trip_details_page.dart';
import 'package:bikes_user/app/ui/android/pages/view_point/view_point_page.dart';
import 'package:bikes_user/app/ui/android/pages/view_user/view_user_page.dart';
import 'package:bikes_user/app/ui/android/pages/finding_biker/finding_biker_fail_page.dart';
import 'package:bikes_user/app/ui/android/pages/finding_biker/finding_biker_page.dart';
import 'package:bikes_user/app/ui/android/pages/get_trip/get_trip_success_page.dart';
import 'package:bikes_user/app/ui/android/pages/home/home_page.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/manage_bike_page.dart';
import 'package:bikes_user/app/ui/android/pages/open/open_page.dart';
import 'package:bikes_user/app/ui/android/pages/profile/profile_page.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/register_page.dart';
import 'package:bikes_user/app/ui/android/pages/login_register/verify_phone_page.dart';
import 'package:bikes_user/app/ui/android/pages/sos_number/sos_number_page.dart';
import 'package:bikes_user/app/ui/android/pages/top_biker/top_biker_page.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/trip_history_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/your_voucher_details_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/your_vouchers_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_details_page.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_page.dart';
import 'package:bikes_user/app/ui/android/pages/welcome/welcome_page.dart';
import 'package:get/get.dart';
import 'package:bikes_user/app/bindings/feedback_binding.dart';
import 'package:bikes_user/app/ui/android/pages/feedback/feedback_page.dart';
import 'package:bikes_user/app/bindings/profile_binding.dart';
import 'package:bikes_user/app/bindings/home_binding.dart';
import 'package:bikes_user/app/bindings/manage_bike_binding.dart';

class AppPages {
  static final pages = [
    GetPage(name: CommonRoutes.ON_BOARD, page: () => OnBoardPage()),
    GetPage(
      name: CommonRoutes.OPEN,
      page: () => OpenPage(),
      binding: OpenPageBingding(),
    ),
    GetPage(name: CommonRoutes.WELCOME, page: () => WelcomePage()),
    GetPage(
      name: CommonRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: CommonRoutes.VERIFY_PHONE,
        page: () {
          final phone = Get.arguments['fullPhone'] ?? '';
          return VerifyPhonePage.initial(phone);
        },
        binding: VerifyPhoneBinding()),
    GetPage(
        name: CommonRoutes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: CommonRoutes.CHOOSE_MODE,
        page: () => ChooseModePage(),
        bindings: <Bindings>[ChooseModeBinding(), UserBinding()]),
    GetPage(
        name: CommonRoutes.TRIP_HISTORY,
        page: () => TripHistoryPage(),
        bindings: <Bindings>[TripHistoryBinding(), TripBinding()]),
    GetPage(
        name: CommonRoutes.HOME,
        page: () => HomePage(),
        bindings: <Bindings>[
          HomeBinding(),
          ProfileBinding(),
          UserBinding(),
          TripBinding(),
          StationBinding(),
          BikeBinding(),
          TripDetailsBinding(),
          PathshareBinding(),
        ]),
    GetPage(
      name: CommonRoutes.REQUIRE_ADD_BIKE,
      page: () => RequireAddBikePage(),
    ),
    GetPage(
      name: CommonRoutes.CHO_NOW,
      page: () => ChoNowSettingsPage(),
      bindings: <Bindings>[
        ChoNowSettingsBinding(),
        StationBinding(),
      ],
    ),
    GetPage(
      name: CommonRoutes.TOP_BIKER,
      page: () => TopBikerPage(),
      binding: TopBikerBinding(),
    ),
    GetPage(
      name: CommonRoutes.PROFILE,
      page: () => ProfilePage(),
      bindings: <Bindings>[
        ProfileBinding(),
        UserBinding(),
        WalletBinding(),
        BikeBinding()
      ],
    ),
    GetPage(
        name: CommonRoutes.EDIT_PROFILE,
        page: () => EditProfilePage(),
        bindings: <Bindings>[ProfileBinding(), UserBinding()]),
    GetPage(
        name: CommonRoutes.FEEDBACK,
        page: () => FeedbackPage(),
        binding: FeedbackBinding()),
    GetPage(name: CommonRoutes.FIND_BIKER, page: () => FindingBikerPage()),
    GetPage(
        name: CommonRoutes.FIND_BIKER_SUCCESS,
        page: () => FindingBikerSuccessPage()),
    GetPage(
        name: CommonRoutes.FIND_BIKER_FAIL, page: () => FindingBikerFailPage()),
    GetPage(
        name: CommonRoutes.GET_TRIP_SUCCESS, page: () => GetTripSuccessPage()),
    GetPage(
        name: CommonRoutes.EXCHANGE_VOUCHER,
        page: () => VoucherPage(),
        binding: VoucherBinding()),
    GetPage(
        name: CommonRoutes.TRIP_DETAILS,
        page: () => TripDetailsPage(),
        bindings: [
          TripDetailsBinding(),
          TripBinding(),
          HomeBinding(),
          TripHistoryBinding(),
          ProfileBinding(),
          PathshareBinding(),
        ]),
    GetPage(
        name: CommonRoutes.TRIP_DETAILS_FULL_MAP,
        page: () => TripDetailsFullMapPage(),
        bindings: <Bindings>[
          TripDetailsBinding(),
          TripBinding(),
        ]),
    GetPage(
        name: CommonRoutes.VIEW_USER,
        page: () => ViewUserPage(),
        bindings: [ViewUserBinding(), UserBinding(), TripBinding()]),
    GetPage(
        name: CommonRoutes.BOOK_TRIP,
        page: () => BookTripPage(),
        binding: BookTripBinding()),
    GetPage(
        name: CommonRoutes.BOOK_SCHEDULE_TRIP,
        page: () => BookScheduleTripPage(),
        binding: BookScheduleTripBinding()),
    GetPage(
      name: CommonRoutes.MANAGE_BIKE,
      page: () => ManageBikePage(),
      bindings: <Bindings>[ManageBikeBinding(), BikeBinding()],
    ),
    GetPage(
        name: CommonRoutes.ADD_BIKE,
        page: () => AddBikePage(),
        bindings: <Bindings>[
          AddBikeBinding(),
          ManageBikeBinding(),
          BikeBinding()
        ]),
    GetPage(
      name: CommonRoutes.VOUCHER_DETAILS,
      page: () => VoucherDetailPage(),
      binding: VoucherBinding(),
    ),
    GetPage(
      name: CommonRoutes.YOUR_VOUCHER_DETAIL,
      page: () => YourVoucherDetailPage(),
      binding: VoucherBinding(),
    ),
    GetPage(
        name: CommonRoutes.APP_SETTING,
        page: () => AppSettingPage(),
        binding: AppSettingBinding()),
    GetPage(
      name: CommonRoutes.YOUR_VOUCHERS,
      page: () => YourVoucherPage(),
      binding: VoucherBinding(),
    ),
    GetPage(
        name: CommonRoutes.ADDRESS_BOOK,
        page: () => AddressBookPage(),
        binding: AddressBookBinding()),
    GetPage(
        name: CommonRoutes.EDIT_ADDRESS_BOOK,
        page: () => EditAddressBookPage(),
        binding: EditAddressBookBinding()),
    GetPage(
        name: CommonRoutes.ADD_ADDRESS_BOOK,
        page: () => AddAddressBookPage(),
        binding: AddAddressBookBinding()),
    GetPage(
        name: CommonRoutes.SOS_NUMBER,
        page: () => SOSNumberPage(),
        binding: SOSNumberBinding()),
    GetPage(
        name: CommonRoutes.ADD_SOS_NUMBER,
        page: () => AddSOSNumberPage(),
        binding: AddSOSNumberBinding()),
    GetPage(
        name: CommonRoutes.EDIT_SOS_NUMBER,
        page: () => EditSOSNumberPage(),
        binding: EditSOSNumberBinding()),
    GetPage(
        name: CommonRoutes.BAN_LIST,
        page: () => BanListPage(),
        binding: BanListBinding()),
    GetPage(name: CommonRoutes.TAKE_PICTURE, page: () => AddBikeCameraPage()),
    GetPage(
        name: CommonRoutes.POINT,
        page: () => ViewPointPage(),
        binding: ViewPointBinding()),
    GetPage(
        name: CommonRoutes.NOTIFICATION,
        page: () => NotificationPage(),
        binding: NotificationBinding()),
  ];
}
