import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/network/config_network.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(EndPoint.signup)
  Future<dynamic> signup(
    @Field('fullname') String name,
    @Field('email') String email,
    @Field('phoneNumber') String phone,
    @Field('password') String pass,
  );

  @GET(EndPoint.userVerify + '/{idUser}' + '/activation')
  Future<dynamic> isVerifyUser(@Path('idUser') String idUser);

  @PUT(EndPoint.userVerify + '/{idUser}' + '/activation')
  Future<dynamic> verifyUser(
    @Path('idUser') String idUser,
    @Field('isPhoneVerified') bool? isPhoneVerified,
    @Field('isEmailVerified') bool? isEmailVerified,
  );

  @GET(EndPoint.blackList + '/{idUser}')
  Future<BlackListResponse> getBlackList(
    @Path('idUser') String idUser,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @PUT(EndPoint.blackList)
  Future<dynamic> unBlock({
    @Body() required BlackListItem blackListItem,
  });
}
