/// Contains all strings which used in the app
class CustomStrings {
  // '002.1_welcome_1' screen
  static const String kIntroduction = "Ứng dụng kết nối đi ké xe miễn phí";

  // '003.1_login'
  static const String kLoginButton = "Xác thực bằng email FPT";
  static const String kConfirmTerm = "Bằng việc đăng ký, bạn đồng ý với";
  static const String kTerm = "Điều khoản dịch vụ và Chính sách bảo mật";

  // '004.1_input_phone_no' screen
  static const String kInputPhoneNumber = "Nhập số điện thoại";
  static const String kErrorInputPhoneNumber =
      "Số điện thoại của bạn không hợp lệ";

  // '004.2_verify_phone' screen
  static const String kInputVerifyCode = "Nhập mã xác minh";
  static const String kResendVerifyCode = "Yêu cầu gửi lại mã sau 59 giây";
  static const String kInvalidPin = "Mã xác nhận không chính xác";

  // '004.3_input_name' screen
  static const String kInputName = "Nhập tên của bạn";
  static const String kErrorName = "Tên của bạn không hợp lệ";

  // '004.4_choose_mode' screen
  static const String kChooseMode = "Bắt đầu ứng dụng\nvới vai trò là";
  static const String kBikerRole = "Người chở";
  static const String kKeerRole = "Người đi ké";
  static const String kBikerDescription =
      "Lựa chọn người bạn muốn chở, bắt đầu hành trình, nhận điểm thưởng và đổi lấy những voucher giá trị";
  static const String kKeerDescription =
      "Tạo chuyến đi của bạn và lên xe đi ké!";
  static const String kRemindWords =
      "Bạn có thể đổi sang chế độ còn lại\nkhi sử dụng ứng dụng";

  // 'ke_er_home' screen
  static const String kTopBiker = "Top Biker tháng ";
  static const String kKeerReadyReminder = "Chuyến sắp ké";
  static const String kReminderMinute = " phút ";
  static const String kReminderHour = " tiếng ";
  static const String kReminderLeft = " nữa";
  static const String kArriveAtDestination = "Đã đến";
  static const String kKeerMode = "Đi ké mode";
  static const String kBikerMode = "Chở mode";
  static const String kToday = "Hôm nay";
  static const String kUpcomingTrips = "Những chuyến sắp tới";
  static const String kFinding = "Đang tìm...";
  static const String kCreateTrip =
      "Bạn chưa đặt chuyến nào.\nHãy chọn + và bắt đầu hành trình đi ké!";

  // 'biker_home' screen
  static const String kBikerReadyReminder = "Chuyến sắp chở";
  static const String kFilter = "Lọc chuyến đi đang cần chở";
  static const String kSelectHour = "Chọn giờ";
  static const String kSelectSourceStation = "Chọn điểm đi";
  static const String kSelectDestinationStation = "Chọn điểm đến";
  static const String kDecline = "Từ chối";
  static const String kAccept = "Chấp nhận";

  // 'trip_history' screen
  static const String kHistory = "Lịch sử";
  static const String kKeerHistory = "Đi ké";
  static const String kBikerHistory = "Chở ké";
  static const String kTripFinished = "Thành công";
  static const String kTripCanceled = "Đã hủy";
  static const String kNoKeerHistoryTrips = "Không có lịch sử đi ké";
  static const String kNoBikerHistoryTrips = "Không có lịch sử chở ké";

  // bottom tabbar
  static const String kHome = "Trang chủ";
  static const String kKeerActivities = "Lịch ké";
  static const String kBikerActivities = "Lịch chở";

  //'profile' screen
  static const String kEdit = "Chỉnh sửa";
  static const String kSavedAddress = "Sổ địa chỉ";
  static const String kSettings = "Cài đặt";
  static const String kBlockList = "Danh sách hạn chế";
  static const String kSOS = "Số điện thoại S.O.S";
  static const String kHelp = "Trợ giúp/Gọi đến Biiké";
  static const String kRateApp = "Đánh giá ứng dụng";
  static const String kPhoneNo = "Số điện thoại";
  static const String kEmail = "Email";
  static const String kLogOut = "Đăng xuất";

  // 'update_profile' screen
  static const String kEditProfile = "Chỉnh sửa thông tin cá nhân";
  static const String kFullName = "Họ và tên";
  static const String kGender = "Giới tính";
  static const String kMale = "Nam";
  static const String kFemale = "Nữ";
  static const String kOthers = "Khác";
  static const String kSave = "Lưu";

  // 'biker_profile' screen
  static const String kManageBike = "Quản lí xe";

  // 'view_user' screen
  static const String kViewUser = "Xem bạn chở";
  static const String kSchool = "Trường";
  static const String kCall = "Gọi điện";
  static const String kMessage = "Nhắn tin";
  static const String kReport = "Báo cáo";
  static const String kNoHistoryTrip = "Không có lịch sử đi chung";
  static const String kHasHistoryTrip = "Lịch sử đi chung";
  static const String kEnterYourReport =
      "Nhập phản ánh của bạn về người này...";
  static const String kReportAndBlock = "Báo cáo và chặn";
  static const String kConfirmBlock = "Bạn có chắc chắn\nmuốn chặn người này?";
  static const String kSeeBlacklist =
      "Bạn có thể xem lại danh sách chặn\ntại trang hồ sơ cá nhân";
  static const String kSure = "Chắc chắn";
  static const String kThankYouForReport = "Cảm ơn bạn đã báo cáo";
  static const String kSorryMessage =
      "Biiké rất tiếc vì những trải nghiệm chưa được hoàn hảo. Biiké đã nhận được thông tin báo cáo và sẽ xử lý trong thời gian sớm nhất.";

  // 'finding_biker_success' screen
  static const String kFoundBiker = "Đã tìm được người chở bạn!";
  static const String kViewTrip = "Xem chuyến đi";

  // 'get_trip_success' screen
  static const String kGetTripSuccess = "Nhận chở thành công!";

  // 'finding_biker' screen
  static const String kFindingBiker = "Đang tìm người chở";

  // 'finding_biker_fail' screen
  static const String kFindBikerFail = "Không tìm thấy người chở ké";
  static const String kTips =
      "Bạn có thể tạo chuyến đi đặt lịch để tăng khả năng tìm được người chở ké nhé!";
  static const String kBtnExit = "Thoát";
  static const String kBtnReturn = "Quay lại";

  // 'ke_er_feedback' screen
  static const String kTripSuccessBiker = "Chở ké thành công!";
  static const String kTripSuccessKeer = "Đi ké thành công!";
  static const String kBuyReminder =
      "Vì đây là chuyến đi miễn phí, nên đừng quên gửi lời cảm ơn đến người bạn đồng hành, lâu lâu mua một ly cà phê hoặc một ổ bánh mì sẽ là ý tưởng xuất sắc đấy!";
  static const String kRateReminder =
      "Hãy đánh giá trải nghiệm của bạn cùng \"người ấy\" hôm nay nhé!";
  static const String kBtnSend = "Gửi";

  // 'biker_point' screen
  static const String kListVouchers = "Danh mục đổi quà";
  static const String kTradedVouchers = "Quà đã đổi";

  // 'trip_detail' screen
  static const String kTripDetails = "Chi tiết chuyến đi";
  static const String kSupport = "Trợ giúp";
  static const String kNewTrip = "Đã tạo";
  static const String kTripHasBiker = "Đã được nhận chở";
  static const String kCancelTrip = "Hủy chuyến";
  static const String kConfirmArrival = "Đánh dấu đã đến";
  static const String kStartTrip = "Bắt đầu chuyến đi";
  static const String kCompleteTrip = "Hoàn thành";

  // 'book_trip' screen
  static const String kBookNewTrip = "Tạo chuyến đi ké mới";
  static const String kFrom = "Từ";
  static const String kChooseFrom = "Chọn điểm đi";
  static const String kTo = "Đến";
  static const String kChooseTo = "Chọn điểm đến";
  static const String kBookScheduleTrip = "Đặt lịch ké";
  static const String kBookNowTrip = "Ké now";

  // 'book_schedule_trip' screen
  static const String kTime = "Thời gian";
  static const String kChooseDate = "Chọn ngày";
  static const String kChooseTime = "Chọn giờ";
  static const String kRepeat = "Lặp lại";
  static const String kRepeatTo = "Lặp lại đến";
  static const String kCancel = "Hủy";

  // 'bike_manager' screen
  static const String kBikeVerified = 'Đã xác minh';
  static const String kWaitingVerified = 'Đang xác minh';
  static const String kBikeOwner = 'Tên chủ xe';
  static const String kBikeCategory = 'Loại xe';
  static const String kBikeBrand = 'Nhãn hiệu';
  static const String kBikeColor = 'Màu sơn';
  static const String kSuggestAddBike =
      'Bạn chưa thêm xe.\nHãy chọn + để thêm xe';

  // 'add_bike' screen
  static const String kAddBike = 'Thêm xe mới';
  static const String kCheckBikeInfo = 'Vui lòng kiểm tra thông tin xe';
  static const String kNumberPlate = 'Biển số đăng ký';
  static const String kTakePictureAgain = 'Chụp lại';

  // Error message
  static const String kError = 'Thông báo lỗi';
  static const String kErrorMessage =
      'Có lỗi xảy ra, vui lòng thử lại sau hoặc liên hệ với bộ phận phát triển của Biiké';

  // Default area name
  static const String fptHCMUni = 'Đại học FPT TP.HCM';
}
