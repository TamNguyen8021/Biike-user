// import 'package:bikes_user/app/data/enums/role_enum.dart';
// import 'package:bikes_user/app/common/values/custom_strings.dart';
// import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
// import 'package:bikes_user/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// /// A list of history trips
// class ListHistoryTrips extends StatelessWidget {
//   final List<dynamic> listHistoryTrips;
//   final double itemPadding;

//   const ListHistoryTrips(
//       {Key? key, required this.listHistoryTrips, required this.itemPadding})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String _noHistoryMessage = '';

//     switch (Biike.role.value) {
//       case Role.keer:
//         _noHistoryMessage = CustomStrings.kNoKeerHistoryTrips.tr;
//         break;
//       case Role.biker:
//         _noHistoryMessage = CustomStrings.kNoBikerHistoryTrips.tr;
//         break;
//       default:
//         _noHistoryMessage = CustomStrings.kNoHistoryTrip.tr;
//         break;
//     }

//     if (listHistoryTrips.isEmpty) {
//       return Text(_noHistoryMessage);
//     } else {
//       return ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemCount: listHistoryTrips.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: itemPadding),
//               child: HistoryTripCard(
//                   tripId: listHistoryTrips.elementAt(index).tripId,
//                   userId: listHistoryTrips.elementAt(index).userId,
//                   dateTime: listHistoryTrips.elementAt(index).dateTime,
//                   status: listHistoryTrips.elementAt(index).status,
//                   sourceStation:
//                       listHistoryTrips.elementAt(index).sourceStation,
//                   destinationStation:
//                       listHistoryTrips.elementAt(index).destinationStation),
//             );
//           });
//     }
//   }
// }
