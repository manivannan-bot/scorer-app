// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
//
//
// import '../../utils/images.dart';
// import '../utils/colours.dart';
// import '../utils/sizes.dart';
//
//
// class Grounds extends StatefulWidget {
//   final String id;
//   const Grounds(this.id, {Key? key}) : super(key: key);
//
//   @override
//   State<Grounds> createState() => _GroundsState();
// }
//
// class _GroundsState extends State<Grounds> {
//
//   bool loading = false;
//   bool searching = false;
//   bool isResultEmpty = false;
//   String searchedText = "";
//   bool locationFilter = false;
//
//   Future<List<GroundList>>? futureData1;
//   List<GroundList> groundsList = [];
//   List<GroundList> searchedList = [];
//   TextEditingController searchController = TextEditingController();
//
//   getGroundsList(String id){
//     futureData1 = BookingProvider().getGroundsList(id).then((value) {
//       setState(() {
//         groundsList = [];
//         groundsList.addAll(value);
//       });
//       print(groundsList);
//       return groundsList;
//     });
//   }
//
//   favRefresh() async {
//     setState(() {
//       loading = true;
//     });
//     getGroundsList(widget.id);
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       loading = false;
//     });
//   }
//
//   refresh(String id) async {
//     setState(() {
//       loading = true;
//     });
//     getGroundsList(id);
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       loading = false;
//     });
//   }
//
//   onSearchCategory(String search) {
//     setState(() {
//       searching = true;
//       searchedText = search;
//       searchedList = groundsList.where((ground) => ground.groundName!.toLowerCase().toString().contains(search.toLowerCase())
//           || ground.organizerName!.toLowerCase().toString().contains(search.toLowerCase())
//           || ground.location!.toLowerCase().toString().contains(search.toLowerCase())).toList();
//       if (searchedList.isEmpty) {
//         setState(() {
//           isResultEmpty = true;
//         });
//       } else {
//         setState(() {
//           isResultEmpty = false;
//         });
//       }
//       searching = false;
//     });
//   }
//
//   filterGroundsByCity(String city) {
//     print(city);
//     setState(() {
//       locationFilter = true;
//       searching = true;
//       searchedText = city;
//       searchedList = groundsList.where((ground) => ground.location!.toLowerCase().toString().contains(city.toLowerCase())).toList();
//       print(searchedList);
//       if (searchedList.isEmpty) {
//         setState(() {
//           isResultEmpty = true;
//         });
//       } else {
//         setState(() {
//           isResultEmpty = false;
//         });
//       }
//       // searching = false;
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     refresh(widget.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     var connectionStatus = Provider.of<ConnectivityStatus>(context);
//     if (connectionStatus == ConnectivityStatus.offline) {
//       return const NoInternetView();
//     }
//     return GestureDetector(
//       onTap: (){
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus) {
//           currentFocus.unfocus();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColor.bgColor,
//         body: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 3.w
//               ) + EdgeInsets.only(
//                   top: 2.h + statusBarHeight, bottom: 2.h
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                       onTap:(){
//                         Navigator.pop(context);
//                       },
//                       child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
//                   Text("Grounds",
//                     style: fontMedium.copyWith(
//                         fontSize: 15.sp,
//                         color: AppColor.textColor
//                     ),),
//                   SizedBox(width: 7.w,),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 5.w
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   locationFilter
//                       ? const SizedBox()
//                       : Expanded(
//                     child: Container(
//                       height: 5.h,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5.w,
//                         vertical: 1.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColor.lightColor,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 controller: searchController,
//                                 cursorColor: AppColor.secondaryColor,
//                                 onChanged: (value) {
//                                   onSearchCategory(value);
//                                   setState(() {
//                                     if (value.isEmpty) {
//                                       searching = false;
//                                     }
//                                     else{
//                                       searching = true;
//                                     }
//                                   });
//                                 },
//                                 decoration: InputDecoration(
//                                   isDense: true,
//                                   border: InputBorder.none,
//                                   hintText: "Search for grounds",
//                                   hintStyle: fontRegular.copyWith(
//                                       fontSize: 10.sp,
//                                       color: AppColor.textMildColor
//                                   ),),
//                               ),
//                             ),
//                             searching
//                                 ? InkWell(
//                                 onTap: (){
//                                   setState(() {
//                                     searchController.clear();
//                                     searching = false;
//                                   });
//                                   FocusScopeNode currentFocus = FocusScope.of(context);
//                                   if (!currentFocus.hasPrimaryFocus) {
//                                     currentFocus.unfocus();
//                                   }
//                                 },
//                                 child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
//                                 : SvgPicture.asset(Images.searchIcon, color: AppColor.iconColour, width: 3.5.w,),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   locationFilter
//                       ? const SizedBox()
//                       : SizedBox(width: 5.w),
//                   Bounceable(
//                     onTap: (){
//                       FocusScopeNode currentFocus = FocusScope.of(context);
//                       if (!currentFocus.hasPrimaryFocus) {
//                         currentFocus.unfocus();
//                       }
//                       openGroundLocationBottomSheet();
//                     },
//                     child: Container(
//                       height: 5.h,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 4.w,
//                         vertical: 1.5.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColor.primaryColor,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: Row(
//                         children: [
//                           Consumer<BookingProvider>(
//                               builder: (context, filter, child) {
//                                 return Text(filter.locationFilterCity == "" ? "Location" : filter.locationFilterCity,
//                                   style: fontRegular.copyWith(
//                                       fontSize: 10.5.sp,
//                                       color: AppColor.textColor
//                                   ),);
//                               }
//                           ),
//                           SizedBox(width: 1.5.w),
//                           Icon(Icons.keyboard_arrow_down, color: AppColor.textColor, size: 4.w,),
//                         ],
//                       ),
//                     ),
//                   ),
//                   locationFilter
//                       ? const Spacer()
//                       : const SizedBox(),
//                   !locationFilter
//                       ? const SizedBox()
//                       : Row(
//                     children: [
//                       SizedBox(width: 5.w),
//                       Bounceable(
//                         onTap: (){
//                           setState((){
//                             locationFilter = false;
//                             searching = false;
//                           });
//                           Provider.of<BookingProvider>(context, listen: false).removeFilterCity();
//                           refresh(widget.id);
//                         },
//                         child: Container(
//                           height: 5.h,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 4.w,
//                             vertical: 1.5.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColor.redColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           child: Text("Clear filters",
//                             style: fontRegular.copyWith(
//                                 fontSize: 10.5.sp,
//                                 color: AppColor.redColor
//                             ),),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             if(loading)...[
//               const Loader(),
//             ]
//             else if(searching)...[
//               if(isResultEmpty && searching)...[
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.h),
//                   child: Text(
//                     "No grounds found",
//                     style: fontBold.copyWith(
//                         color: AppColor.redColor, fontSize: 14.sp),
//                   ),
//                 )
//               ]
//               else if(!isResultEmpty && searching)...[
//                 Expanded(
//                   child: FadeInUp(
//                     preferences: const AnimationPreferences(
//                         duration: Duration(milliseconds: 400)
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 5.w),
//                       child: GridView.builder(
//                         physics: const BouncingScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 4.h,
//                             crossAxisSpacing: 4.w,
//                             childAspectRatio: 0.7
//                         ),
//                         itemCount: searchedList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Bounceable(
//                             onTap:(){
//                               FocusScopeNode currentFocus = FocusScope.of(context);
//                               if (!currentFocus.hasPrimaryFocus) {
//                                 currentFocus.unfocus();
//                               }
//                               Provider.of<TeamProvider>(context, listen: false).clearTeam();
//                               Navigator.push(context, ScaleRoute(page: BookGroundScreen(searchedList[index].id.toString())))
//                                   .then((value){
//                                 favRefresh();
//                               });
//                             },
//                             child: GroundCard(
//                                 searchedList[index].mainImage.toString(),
//                                 searchedList[index].organizerName.toString(),
//                                 searchedList[index].groundName.toString(),
//                                 searchedList[index].location.toString(),
//                                 searchedList[index].id.toString(),
//                                 searchedList[index].isFav == 1 ? true : false,
//                                 searchedList[index].groundBookingCost.toString(),
//                                 searchedList[index].groundContactNumber.toString(),
//                                 favRefresh
//                             ),
//                           );
//                         },
//
//                       ),
//                     ),
//                   ),
//                 )
//               ]
//             ]
//             else if(isResultEmpty || !searching)...[
//                 Expanded(
//                   child: groundsList.isEmpty
//                       ? Padding(
//                     padding: EdgeInsets.only(top: 5.h),
//                     child: Text(
//                       "No grounds found",
//                       style: fontBold.copyWith(
//                           color: AppColor.redColor, fontSize: 14.sp),
//                     ),
//                   ) : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.w),
//                     child: GridView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 4.h,
//                           crossAxisSpacing: 4.w,
//                           childAspectRatio: 0.7
//                       ),
//                       itemCount: groundsList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Bounceable(
//                           onTap:(){
//                             FocusScopeNode currentFocus = FocusScope.of(context);
//                             if (!currentFocus.hasPrimaryFocus) {
//                               currentFocus.unfocus();
//                             }
//                             Provider.of<TeamProvider>(context, listen: false).clearTeam();
//                             Navigator.push(context, ScaleRoute(page: BookGroundScreen(groundsList[index].id.toString())))
//                                 .then((value) {
//                               favRefresh();
//                             });
//                           },
//                           child: GroundCard(
//                               groundsList[index].mainImage.toString(),
//                               groundsList[index].organizerName.toString(),
//                               groundsList[index].groundName.toString(),
//                               groundsList[index].location.toString(),
//                               groundsList[index].id.toString(),
//                               groundsList[index].isFav == 1 ? true : false,
//                               groundsList[index].groundBookingCost.toString(),
//                               groundsList[index].groundContactNumber.toString(),
//                               favRefresh
//                           ),
//                         );
//                       },
//
//                     ),
//                   ),
//                 ),
//               ],
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   void openGroundLocationBottomSheet() {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return const GroundLocations();
//         }).then((value) {
//       final city = Provider.of<BookingProvider>(context, listen: false).locationFilterCity;
//       final cityId = Provider.of<BookingProvider>(context, listen: false).locationFilterCityId;
//       print("filter location city $city $cityId");
//       if(cityId != ""){
//         refresh(cityId);
//       }
//     });
//   }
// }
//
