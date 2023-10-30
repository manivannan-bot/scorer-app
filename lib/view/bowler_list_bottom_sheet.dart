// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
//
// import '../models/player_list_model.dart';
// import '../utils/colours.dart';
// import '../utils/images.dart';
// import '../utils/sizes.dart';
// import '../widgets/cancel_btn.dart';
// import '../widgets/ok_btn.dart';
//
// class BowlerListBottomSheet extends StatefulWidget {
//   final String? selectedBTeamName;
//   final VoidCallback onItemSelected;
//   const BowlerListBottomSheet(this.selectedBTeamName, this.onItemSelected, {super.key});
//
//   @override
//   State<BowlerListBottomSheet> createState() => _BowlerListBottomSheetState();
// }
//
// class _BowlerListBottomSheetState extends State<BowlerListBottomSheet> {
//
//   int? localBowlerIndex ;
//   bool isResultEmpty=true;
//   bool searching = false;
//   String searchedText = "";
//   TextEditingController searchController = TextEditingController();
//   List<BowlingPlayers> searchedList = [];
//   bool showError=false;
//   List<BowlingPlayers>? itemsBowler= [];
//
//   onSearchCategory(String search) {
//     setState(() {
//       searching = true;
//       searchedText = search;
//       searchedList = itemsBowler!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 90.h,
//       padding: EdgeInsets.symmetric(vertical: 2.h),
//       decoration: const BoxDecoration(
//           color: AppColor.lightColor,
//           borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 5.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                     onTap: (){
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.arrow_back,size: 7.w,)),
//                 Text("Select Bowler",style: fontMedium.copyWith(
//                   fontSize: 18.sp,
//                   color: AppColor.blackColour,
//                 ),),
//                 SizedBox(width: 7.w,),
//               ],
//             ),
//           ),
//           SizedBox(height: 1.h,),
//           const Divider(
//             thickness: 1,
//             color: Color(0xffD3D3D3),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: const Color(0xffF8F9FA),
//               ),
//               child: Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: searchController,
//                         cursorColor: AppColor.secondaryColor,
//                         onChanged: (value) {
//                           onSearchCategory(value);
//                           setState(() {
//                             if (value.isEmpty) {
//                               searching = false;
//                             }
//                             else{
//                               searching = true;
//                             }
//                           });
//                         },
//                         decoration: InputDecoration(
//                           isDense: true,
//                           border: InputBorder.none,
//                           hintText: "Search for bowlers",
//                           hintStyle: fontRegular.copyWith(
//                               fontSize: 10.sp,
//                               color: AppColor.textMildColor
//                           ),),
//                       ),
//                     ),
//                     searching
//                         ? InkWell(
//                         onTap: (){
//                           setState(() {
//                             searchController.clear();
//                             searching = false;
//                           });
//                           FocusScopeNode currentFocus = FocusScope.of(context);
//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }
//                           onSearchCategory(" ");
//                         },
//                         child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
//                         : SvgPicture.asset(Images.searchIcon, color: AppColor.iconColour, width: 3.5.w,),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: Text('$selectedBTeamName',style: fontMedium.copyWith(
//                 fontSize:14.sp,
//                 color: AppColor.pri
//             ),),
//           ),
//           // Divider(
//           //   color: Color(0xffD3D3D3),
//           // ),
//           const Divider(
//             thickness: 0.5,
//             color: Color(0xffD3D3D3),
//           ),
//           if(isResultEmpty && searching)...[
//             Padding(
//               padding: EdgeInsets.only(top: 5.h),
//               child: Text(
//                 "No players found",
//                 style: fontBold.copyWith(
//                     color: AppColor.redColor, fontSize: 14.sp),
//               ),
//             )
//           ]
//           else if(!isResultEmpty&&searching)...[
//             Expanded(
//               child:   ListView.separated(
//                 separatorBuilder:(context ,_) {
//                   return const Divider(
//                     thickness: 0.6,
//                   );
//                 },
//                 itemCount: searchedList.length,
//                 itemBuilder: (context, index) {
//                   final isActive=searchedList[index].active??0;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (localBowlerIndex  == index) {
//                           localBowlerIndex  = null; // Deselect the item if it's already selected
//                         } else {
//                           localBowlerIndex  = index; // Select the item if it's not selected
//                         }
//                         onItemSelected(localBowlerIndex);
//                       });
//                     },
//                     child:Opacity(opacity: isActive==1?0.5:1,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
//                         child: Row(
//                           children: [
//                             //circular button
//                             Container(
//                               height: 20.0, // Adjust the height as needed
//                               width: 20.0,  // Adjust the width as needed
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: localBowlerIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
//                               ),
//                               child: const Center(
//                                 child: Icon(
//                                   Icons.circle_outlined, // You can change the icon as needed
//                                   color: Colors.white, // Icon color
//                                   size: 20.0, // Icon size
//                                 ),
//                               ),
//                             ), SizedBox(width: 3.w,),
//                             Image.asset(Images.playersImage,width: 10.w,),
//                             SizedBox(width: 2.w,),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(searchedList[index].playerName??'-',style: fontMedium.copyWith(
//                                   fontSize: 12.sp,
//                                   color: AppColor.blackColour,
//                                 ),),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height:1.h,
//                                       width: 2.w,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: AppColor.pri,
//                                       ),
//                                     ),
//                                     SizedBox(width: 2.w,),
//                                     Text(searchedList[index].bowlingStyle??'-',style: fontMedium.copyWith(
//                                         fontSize: 11.sp,
//                                         color: const Color(0xff555555)
//                                     ),),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                             const Spacer(),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   );
//                 },
//               ),
//             ),
//           ]
//           else...[
//               Expanded(
//                 child:   ListView.separated(
//                   separatorBuilder:(context ,_) {
//                     return const Divider(
//                       thickness: 0.6,
//                     );
//                   },
//                   itemCount: searchedList.length,
//                   itemBuilder: (context, index) {
//                     final isActive=searchedList[index].active??0;
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (localBowlerIndex  == index) {
//                             localBowlerIndex  = null; // Deselect the item if it's already selected
//                           } else {
//                             localBowlerIndex  = index; // Select the item if it's not selected
//                           }
//                           onItemSelected(localBowlerIndex);
//                         });
//                       },
//                       child:Opacity(opacity: isActive==1?0.5:1,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
//                           child: Row(
//                             children: [
//                               //circular button
//                               Container(
//                                 height: 20.0, // Adjust the height as needed
//                                 width: 20.0,  // Adjust the width as needed
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: localBowlerIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
//                                 ),
//                                 child: const Center(
//                                   child: Icon(
//                                     Icons.circle_outlined, // You can change the icon as needed
//                                     color: Colors.white, // Icon color
//                                     size: 20.0, // Icon size
//                                   ),
//                                 ),
//                               ), SizedBox(width: 3.w,),
//                               Image.asset(Images.playersImage,width: 10.w,),
//                               SizedBox(width: 2.w,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(searchedList[index].playerName??'-',style: fontMedium.copyWith(
//                                     fontSize: 12.sp,
//                                     color: AppColor.blackColour,
//                                   ),),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         height:1.h,
//                                         width: 2.w,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(50),
//                                           color: AppColor.pri,
//                                         ),
//                                       ),
//                                       SizedBox(width: 2.w,),
//                                       Text(searchedList[index].bowlingStyle??'-',style: fontMedium.copyWith(
//                                           fontSize: 11.sp,
//                                           color: const Color(0xff555555)
//                                       ),),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                               const Spacer(),
//
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     );
//                   },
//                 ),
//               ),
//             ],
//
//
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
//             decoration: const BoxDecoration(
//               color: AppColor.lightColor,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Visibility(visible:showError,
//                   child: Text('Please Select one Player',style: fontMedium.copyWith(color: Colors.red),),
//
//                 ),
//                 GestureDetector(onTap:(){
//                   Navigator.pop(context);
//                 },
//                     child: const CancelBtn("Cancel")),
//                 SizedBox(width: 2.w,),
//                 GestureDetector(onTap:()async {
//
//                   if(localBowlerIndex!=null){
//                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                     await prefs.setInt('bowler_id', searchedList[localBowlerIndex!].playerId!);
//                     await prefs.setInt('bowler_change', 0);
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pop(context);
//                     });
//                   }else{
//                     setState(() {showError=true;});
//                     Timer(const Duration(seconds: 4), () {setState(() {showError = false;});});
//                   }
//
//                 },child: const OkBtn("Ok")),
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
