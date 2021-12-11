/// Contains all strings which used in the app
class CustomStrings {
  // '002.1_welcome_1' screen
  static const String kIntroduction = 'kIntroduction';
  static const String kConfirm = 'kConfirm';

  //'002.,.2,.3' screen
  static const String kSkip = 'kSkip';
  static const String kFree = 'kFree';
  static const String kFirstDescription = 'kFirstDescription';
  static const String kSecondDescription = 'kSecondDescription';
  static const String kThirdDescription = 'kThirdDescription';
  static const String kConnectSociety = 'kConnectSociety';
  static const String kProtectEnvironment = 'kProtectEnvironment';
  static const String kStart = 'kStart';

  // '003.1_login'
  static const String kForgotPassword = 'kForgotPassword';
  static const String kSendResetPasswordEmail = 'kSendResetPasswordEmail';
  static const String kInputEmail = 'kInputEmail';
  static const String kPassword = 'kPassword';
  static const String kInputPassword = 'kInputPassword';
  static const String kLogin = 'kLogin';
  static const String kNoAccount = 'kNoAccount';
  static const String kWrongAccount = 'kWrongAccount';
  static const String kUnVerifiedEmail = 'kUnVerifiedEmail';
  static const String kLoginExceptionError = 'kLoginExceptionError';
  static const String kEmptyToken = 'kEmptyToken';

  // 'register' screen
  static const String kConfirmTerm = 'kConfirmTerm';
  static const String kAnd = 'kAnd';
  static const String kRegister = 'kRegister';
  static const String kHasAccount = 'kHasAccount';
  static const String kInputName = 'kInputName';
  static const String kInputPhoneNumber = 'kInputPhoneNumber';
  static const String kErrorInputPhoneNumber = 'kErrorInputPhoneNumber';
  static const String kSentVerifiedEmail = 'kSentVerifiedEmail';

  // '004.2_verify_phone' screen
  static const String kInputVerifyCode = 'kInputVerifyCode';
  static const String kResendVerifyCode = 'kResendVerifyCode';
  static const String kInvalidPin = 'kInvalidPin';

  // '004.3_input_name' screen
  static const String kErrorName = 'kErrorName';
  static const String kErrorEmail = 'kErrorEmail';

  // '004.4_choose_mode' screen
  static const String kChooseMode = 'kChooseMode';
  static const String kBikerRole = 'kBikerRole';
  static const String kKeerRole = 'kKeerRole';
  static const String kBikerDescription = 'kBikerDescription';
  static const String kKeerDescription = 'kKeerDescription';
  static const String kRemindWords = 'kRemindWords';

  // 'ke_er_home' screen
  static const String kTopBiker = 'kTopBiker';
  static const String kKeerReadyReminder = 'kKeerReadyReminder';
  static const String kReminderMinute = 'kReminderMinute';
  static const String kReminderHour = 'kReminderHour';
  static const String kReminderLeft = 'kReminderLeft';
  static const String kArriveAtDestination = 'kArriveAtDestination';
  static const String kKeerMode = 'kKeerMode';
  static const String kBikerMode = 'kBikerMode';
  static const String kToday = 'kToday';
  static const String kUpcomingTrips = 'kUpcomingTrips';
  static const String kFinding = 'kFinding';
  static const String kCreateTrip = 'kCreateTrip';
  static const String kConfirmArrivalTitle = 'kConfirmArrivalTitle';
  static const String kConfirmArrivalMessageForKeer =
      'kConfirmArrivalMessageForKeer';
  static const String kConfirmArrivalMessageForBiker =
      'kConfirmArrivalMessageForBiker';
  static const String kConfirmExitApp = 'kConfirmExitApp';
  static const String kWaitingAdminVerifiedBike = 'kWaitingAdminVerifiedBike';

  // 'biker_home' screen
  static const String kNoKeNowTrip = 'kNoKeNowTrip';
  static const String kBikerReadyReminder = 'kBikerReadyReminder';
  static const String kFilter = 'kFilter';
  static const String kSelectHour = 'kSelectHour';
  static const String kSelectSourceStation = 'kSelectSourceStation';
  static const String kSelectDestinationStation = 'kSelectDestinationStation';
  static const String kAccept = 'kAccept';
  static const String kAcceptSuccessful = 'kAcceptSuccessful';
  static const String kSearchAgain = 'kSearchAgain';
  static const String kSearch = 'kSearch';

  // 'require_add_bike' screen
  static const String kNeedAddBikeToBecomeBiker = 'kNeedAddBikeToBecomeBiker';

  // 'cho_now' screen
  static const String kChoNow = 'kChoNow';
  static const List<String> kChoNowDescription = [
    'kChoNowDescription1',
    'kChoNowDescription2',
    'kChoNowDescription3',
  ];
  static const String kChoNowSettings = 'kChoNowSettings';
  static const String kTurnOnChoNow = 'kTurnOnChoNow';
  static const String kChoNowStation = 'kChoNowStation';
  static const String kAddPickUpStation = 'kAddPickUpStation';
  static const String kAddChoNowStation = 'kAddChoNowStation';
  static const String kAdd = 'kAdd';
  static const String kDelete = 'kDelete';
  static const String kChooseStation = 'kChooseStation';
  static const String kAddStationSuccess = 'kAddStationSuccess';
  static const String kEditStationSuccess = 'kEditStationSuccess';
  static const String kDeleteStationSuccess = 'kDeleteStationSuccess';

  // 'top_biker' screen
  static const String kBikerRank = 'kBikerRank';
  static const String kMonth = 'kMonth';
  static const List<String> kTopBikerInfoContents = [
    'kTopBikerInfoFirstContent',
    'kTopBikerInfoSecondContent'
  ];
  static const String kTopBikerInfoThirdContent = 'kTopBikerInfoThirdContent';
  static const String kGotIt = 'kGotIt';

  // 'activity' screen
  static const String kNoUpcomingTrips = 'kNoUpcomingTrips';

  // 'trip_history' screen
  static const String kHistory = 'kHistory';
  static const String kKeerHistory = 'kKeerHistory';
  static const String kBikerHistory = 'kBikerHistory';
  static const String kTripFinished = 'kTripFinished';
  static const String kTripCanceled = 'kTripCanceled';
  static const String kNoKeerHistoryTrips = 'kNoKeerHistoryTrips';
  static const String kNoBikerHistoryTrips = 'kNoBikerHistoryTrips';

  // bottom tabbar
  static const String kHome = 'kHome';
  static const String kKeerActivities = 'kKeerActivities';
  static const String kBikerActivities = 'kBikerActivities';

  //'profile' screen
  static const String kEdit = 'kEdit';
  static const String kBiikeProfile = 'kBiikeProfile';
  static const String kSavedAddress = 'kSavedAddress';
  static const String kSettings = 'kSettings';
  static const String kBlockList = 'kBlockList';
  static const String kSOS = 'kSOS';
  static const String kHelp = 'kHelp';
  static const String kRateApp = 'kRateApp';
  static const String kPhoneNo = 'kPhoneNo';
  static const String kEmail = 'kEmail';
  static const String kChangeLanguage = 'kChangeLanguage';
  static const String kLogOut = 'kLogOut';

  // 'update_profile' screen
  static const String kEditProfile = 'kEditProfile';
  static const String kFullName = 'kFullName';
  static const String kGender = 'kGender';
  static const String kMale = 'kMale';
  static const String kFemale = 'kFemale';
  static const String kOthers = 'kOthers';
  static const String kSave = 'kSave';
  static const String kBirthDate = 'kBirthDate';
  static const String kChooseBirthDate = 'kChooseBirthDate';
  static const String kEditProfileSuccess = 'kEditProfileSuccess';

  // 'account_verification' screen'
  static const String kAccountVerification = 'kAccountVerification';
  static const String kLetsVerifiedAccount = 'kLetsVerifiedAccount';
  static const String kEmailVerification = 'kEmailVerification';
  static const String kEmailVerificationDescription =
      'kEmailVerificationDescription';
  static const String kPhoneVerification = 'kPhoneVerification';
  static const String kPhoneVerificationDescription =
      'kPhoneVerificationDescription';
  static const String kBikeVerification = 'kBikeVerification';
  static const String kBikeVerificationDescription =
      'kBikeVerificationDescription';

  // 'biike_profile' screen
  static const String kOnJourneyWithBiike = 'kOnJourneyWithBiike';
  static const String kNoOfRideTrips = 'kNoOfRideTrips';
  static const String kNoOfFreeTrips = 'kNoOfFreeTrips';
  static const String kNoOfKm = 'kNoOfKm';
  static const String kNoOfGasLitres = 'kNoOfGasLitres';
  static const String kThankYouForChoosingBiike = 'kThankYouForChoosingBiike';
  static const String kFromFPTUniversity = 'kFromFPTUniversity';

  // 'biker_profile' screen
  static const String kManageBike = 'kManageBike';

  // 'view_user' screen
  static const String kViewUser = 'kViewUser';
  static const String kSchool = 'kSchool';
  static const String kCall = 'kCall';
  static const String kMessage = 'kMessage';
  static const String kReport = 'kReport';
  static const String kReportAndBlock = 'kReportAndBlock';
  static const String kNoHistoryTrip = 'kNoHistoryTrip';
  static const String kHasHistoryTrip = 'kHasHistoryTrip';
  static const String kEnterYourReport = 'kEnterYourReport';
  static const String kBlock = 'kBlock';
  static const String kConfirmBlock = 'kConfirmBlock';
  static const String kSeeBlacklist = 'kSeeBlacklist';
  static const String kYes = 'kYes';
  static const String kNo = 'kNo';
  static const String kThankYouForReport = 'kThankYouForReport';
  static const String kSorryMessage = 'kSorryMessage';
  static const String kYouBlockThisPerson = 'kYouBlockThisPerson';

  // 'block_list' screen
  static const String kEmptyBlockList = 'kEmptyBlockList';

  // 'finding_biker_success' screen
  static const String kFoundBiker = 'kFoundBiker';
  static const String kViewTrip = 'kViewTrip';

  // 'get_trip_success' screen
  static const String kGetTripSuccess = 'kGetTripSuccess';

  // 'finding_biker' screen
  static const String kFindingBiker = 'kFindingBiker';

  // 'finding_biker_fail' screen
  static const String kFindBikerFail = 'kFindBikerFail';
  static const String kTips = 'kTips';
  static const String kBtnExit = 'kBtnExit';
  static const String kBtnReturn = 'kBtnReturn';

  // 'feedback' screen
  static const String kTripSuccessBiker = 'kTripSuccessBiker';
  static const String kTripSuccessKeer = 'kTripSuccessKeer';
  static const String kBuyReminder = 'kBuyReminder';
  static const String kRateReminder = 'kRateReminder';
  static const String kBtnSend = 'kBtnSend';
  static const String kSendSuccess = 'kSendSuccess';
  static const String kTipForBiker = 'kTipForBiker';
  static const kCriteria = [
    'kCriteria1',
    'kCriteria2',
    'kCriteria3',
    'kCriteria4',
    'kCriteria5',
    'kCriteria6'
  ];
  static const kKeerCriteriaHigh = [
    'kOnTime',
    'kFamiliarWithTheRoad',
    'kFriendly',
    'kHelmetPrepared'
  ];
  static const kKeerCriteriaLow = [
    'kLate',
    'kRoadBlind',
    'kAngry',
    'kHelmetNonPrepared'
  ];
  static const kBikerCriteriaHigh = [
    'kOnTime',
    'kFriendly',
    'kHappyPartner',
    'kGrateful'
  ];
  static const kBikerCriteriaLow = [
    'kLate',
    'kNotFriendly',
    'kAngry',
    'kDisrespect'
  ];

  // 'biker_point' screen
  static const String kListVouchers = 'kListVouchers';
  static const String kCanExchange = 'kCanExchange';
  static const String kExchanged = 'kExchanged';
  static const String kUsedOrExpired = 'kUsedOrExpired';
  static const String kNearMe = 'kNearMe';

  // 'trip_details' screen
  static const String kTripDetails = 'kTripDetails';
  static const String kSupport = 'kSupport';
  static const String kNewTrip = 'kNewTrip';
  static const String kCancelTrip = 'kCancelTrip';
  static const String kConfirmArrival = 'kConfirmArrival';
  static const String kCompleteTrip = 'kCompleteTrip';
  static const String kTripHasFinished = 'kTripHasFinished';
  static const String kYourFeedback = 'kYourFeedback';
  static const String kPartnerFeedback = 'kPartnerFeedback';
  static const String kExpandMap = 'kExpandMap';
  static const String kMinimizeMap = 'kMinimizeMap';
  static const String kViewRouteInstruction = 'kViewRouteInstruction';
  static const String kStartLocation = 'kStartLocation';
  static const String kEndLocation = 'kEndLocation';
  static const String kYourLocation = 'kYourLocation';
  static const String kCancelTripSuccess = 'kCancelTripSuccess';
  static const String kConfirmCancelTrip = 'kConfirmCancelTrip';
  static const String kViewCancelTripReminder = 'kViewCancelTripReminder';
  static const String kLetUsKnowYourCancelReason = 'kLetUsKnowYourCancelReason';
  static const String kEnterYourCancelReason = 'kEnterYourCancelReason';
  static const String kHelpCenter = 'kHelpCenter';
  static const String kShareLocation = 'kShareLocation';
  static const String kMyLocation = 'kMyLocation';
  static const String kStopSharingLocation = 'kStopSharingLocation';
  static const String kSOSCenter = 'kSOSCenter';
  static const String kMessageWereSent = 'kMessageWereSent';
  static const String kNeedSharingLocationToUseSOS =
      'kNeedSharingLocationToUseSOS';
  static const String kNearestPoliceStation = 'kNearestPoliceStation';
  static const String kNearestHospital = 'kNearestHospital';
  static const String kNearestMechanicShop = 'kNearestMechanicShop';
  static const String kNearestGasStation = 'kNearestGasStation';
  static const String kRoad = 'kRoad';
  static const String kSuburb = 'kSuburb';
  static const String kTown = 'kTown';
  static const String kCity = 'kCity';
  static const String kCountry = 'kCountry';
  static const String kNeedLocationPermission = 'kNeedLocationPermission';
  static const String kSendSOSMessageSuccess = 'kSendSOSMessageSuccess';

  // 'book_trip' screen
  static const String kBookNewTrip = 'kBookNewTrip';
  static const String kFrom = 'kFrom';
  static const String kChooseFrom = 'kChooseFrom';
  static const String kTo = 'kTo';
  static const String kChooseTo = 'kChooseTo';
  static const String kBookScheduleTrip = 'kBookScheduleTrip';
  static const String kBookNowTrip = 'kBookNowTrip';
  static const String kRuleWhenBookTrip = 'kRuleWhenBookTrip';
  static const List<String> kRulesWhenBookTrip = [
    'kRuleBookTrip1',
    'kRuleBookTrip2'
  ];

  // 'book_schedule_trip' screen
  static const String kTime = 'kTime';
  static const String kChooseDate = 'kChooseDate';
  static const String kChooseTime = 'kChooseTime';
  static const String kRepeat = 'kRepeat';
  static const String kCancel = 'kCancel';

  // 'bike_manager' screen
  static const String kBikeVerified = 'kBikeVerified';
  static const String kWaitingVerified = 'kWaitingVerified';
  static const String kBikeOwner = 'kBikeOwner';
  static const String kBikeCategory = 'kBikeCategory';
  static const String kBikeBrand = 'kBikeBrand';
  static const String kBikeColor = 'kBikeColor';
  static const String kSuggestAddBike = 'kSuggestAddBike';
  static const String kConfirmDeleteBike = 'kConfirmDeleteBike';
  static const String kAreYouSureDeleteBike = 'kAreYouSureDeleteBike';

  // 'add_bike' screen
  static const String kAddBike = 'kAddBike';
  static const String kPleaseEnterCorrectBikeInfo =
      'kPleaseEnterCorrectBikeInfo';
  static const String kChangeBike = 'kChangeBike';
  static const String kNumberPlate = 'kNumberPlate';
  static const String kTakePicture = 'kTakePicture';
  static const String kEnterBikeOwner = 'kEnterBikeOwner';
  static const String kEnterBrand = 'kEnterBrand';
  static const String kEnterCategory = 'kEnterCategory';
  static const String kEnterColor = 'kEnterColor';
  static const String kEnterNumberPlate = 'kEnterNumberPlate';
  static const String kNumberPlatePicture = 'kNumberPlatePicture';
  static const String kPleaseTakeNumberPlatePicture =
      'kPleaseTakeNumberPlatePicture';
  static const String kBikeVolume = 'kBikeVolume';
  static const String kEnterVolume = 'kEnterVolume';
  static const String kBikePicture = 'kBikePicture';
  static const String kPleaseTakeBikePicture = 'kPleaseTakeBikePicture';
  static const String kRegistrationPicture = 'kRegistrationPicture';
  static const String kPleaseTakeRegistrationPicture =
      'kPleaseTakeRegistrationPicture';
  static const String kAddBikeSuccess = 'kAddBikeSuccess';
  static const String kDrivingLicenseBackPicture = 'kDrivingLicenseBackPicture';
  static const String kDrivingLicenseFrontPicture =
      'kDrivingLicenseFrontPicture';
  static const String kPleaseTakeDrivingLicenseBackPicture =
      'kPleaseTakeDrivingLicenseBackPicture';
  static const String kPleaseTakeDrivingLicenseFrontPicture =
      'kPleaseTakeDrivingLicenseFrontPicture';

  // 'voucher_detail' screen
  static const String kGiftDetail = 'kGiftDetail';
  static const String kVoucherDetail = 'kVoucherDetail';
  static const String kTermsAndConditions = 'kTermsAndConditions';
  static const String kAvailableUntil = 'kAvailableUntil';
  static const String kExchangeNow = 'kExchangeNow';
  static const String kBrand = 'kBrand';
  static const String kHsd = 'kHsd';
  static const String kYourVouchers = 'kYourVoucher';
  static const String kYourVoucherDetail = 'kYourVoucherDetail';
  static const String kYourCode = 'kYourCode';
  static const String kExchangeVoucherSuccess = 'kExchangeVoucherSuccess';
  static const String kViewAVoucher = 'kViewAVoucher';
  static const String kShowVoucherCode = 'kShowVoucherCode';
  static const String kMarkAsUsed = 'kMarkAsUsed';
  static const String kMarkAsUnused = 'kMarkAsUnused';

  // Default area name
  static const String fptHCMUni = 'fptHCMUni';

  // 'app_setting' screen
  static const String kAppSetting = 'kAppSetting';
  static const String kAccountSecurity = 'kAccountSecurity';
  static const String kChangePassword = 'kChangePassword';
  static const String kLoginByFingerprint = 'kLoginByFingerprint';
  static const String kLanguage = 'kLanguage';
  static const String kCurrentLanguage = 'kCurrentLanguage';
  static const String kOther = 'kOther';
  static const String kFollowOnFacebook = 'kFollowOnFacebook';
  static const String kWebsite = 'kWebsite';
  static const String kTermOfUse = 'kTermOfUse';
  static const String kPrivacyPolicy = 'kPrivacyPolicy';
  static const String kDevelopBy = 'kDevelopBy';
  static const String kDevelopAt = 'kDevelopAt';

  // 'address_book' screen
  static const String kAddressBook = 'kAddressBook';
  static const String kDefault = 'kDefault';

  // 'edit_address_book' screen
  static const String kEditAddressBook = 'kEditAddressBook';

  // 'add_address_book' screen
  static const String kAddAddressBook = 'kAddAddressBook';
  static const String kName = 'kName';
  static const String kAddress = 'kAddress';
  static const String kNote = 'kNote';
  static const String kEnterName = 'kEnterName';
  static const String kSelectAddress = 'kSelectAddress';
  static const String kEnterNote = 'kEnterNote';
  static const String kSetAsDefault = 'kSetAsDefault';

  // 'sos_number' screen
  static const String kSOSNumber = 'kSOSNumber';
  static const String kSOSNumberFirstDescription = 'kSOSNumberFirstDescription';
  static const String kSOSNumberSecondDescription =
      'kSOSNumberSecondDescription';
  static const String kNeedSOS = 'kNeedSOS';
  static const String kSOSNumberThirdDescription = 'kSOSNumberThirdDescription';
  static const String kSOSReachLimit = 'kSOSReachLimit';

  // 'add_sos_number' screen
  static const String kAddSOSNumber = 'kAddSOSNumber';
  static const String kNumberPhone = 'kNumberPhone';
  static const String kEnterNumberPhone = 'kEnterNumberPhone';

  // 'edit_sos_number' screen
  static const String kEditSOSNumber = 'kEditSOSNumber';

  // 'ban_list' screen
  static const String kBanList = 'kBanList';
  static const String kUnBlock = 'kUnBlock';

  // point
  static const String kPoint = 'kPoint';
  static const String kExchangeVoucher = 'kExchangeVoucher';
  static const String kBuyPoint = 'kBuyPoint';
  static const String kYouHave = 'kYouHave';
  static const String kExpired = 'kExpired';
  static const String kFindMore = 'kFindMore';

  // top up point
  static const String kTopUpFromMomo = 'kTopUpFromMomo';
  static const String kEnterPoint = 'kEnterPoint';
  static const String kNeedAmount = 'kNeedAmount';
  static const String kNoted = 'kNoted';
  static const String kTopUpNoted = 'kTopUpNoted';
  static const String kTopUpSuccess = 'kTopUpSuccess';

  // noti
  static const String kNotification = 'kNotification';
  static const String kNewNotification = 'kNewNotification';
  static const String kDeleteNotification = 'kDeleteNotification';
  static const String kAll = 'kAll';
  static const String kView = 'kView';
}
