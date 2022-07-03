// import 'package:chewie/chewie.dart';
// import 'package:flash/flash.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:moa/core/util/constants.dart';
// import 'package:moa/core/util/cubit/cubit.dart';
// import 'package:moa/core/util/cubit/state.dart';
// import 'package:moa/core/util/widgets/my_indicator.dart';
// import 'package:moa/features/test/presentation/widgets/fields_widget.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../../main.dart';
//
// class SearchWidget extends StatefulWidget {
//   const SearchWidget({Key? key}) : super(key: key);
//
//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }
//
// class _SearchWidgetState extends State<SearchWidget> {
//   final videoPlayerController = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//
//   late ChewieController chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     AppCubit.get(context).getPosts();
//     inn();
//   }
//
//   void inn() async {
//     await videoPlayerController.initialize();
//
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: false,
//       looping: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext c) {
//     return BlocConsumer<AppCubit, AppState>(
//       listener: (context, state) {
//         if (state is MessageReceived) {
//           showFlash(
//             context: c,
//             duration: const Duration(seconds: 2),
//             persistent: true,
//             builder: (_, controller) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Flash(
//                   controller: controller,
//                   backgroundColor: Colors.white,
//                   brightness: Brightness.light,
//                   boxShadows: const [BoxShadow(blurRadius: 4)],
//                   barrierBlur: 3.0,
//                   barrierColor: Colors.black38,
//                   barrierDismissible: true,
//                   behavior: FlashBehavior.floating,
//                   position: FlashPosition.top,
//                   child: FlashBar(
//                     title: Text(
//                       'There is a new post',
//                       style: Theme.of(c).textTheme.caption,
//                     ),
//                     content: Text(
//                       'Check new post now',
//                       style: Theme.of(c).textTheme.caption,
//                     ),
//                     showProgressIndicator: true,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0,),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(
//                     10.0,
//                   ),
//                   border: Border.all(
//                     width: 1.0,
//                     color: HexColor(regularGrey),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsetsDirectional.only(
//                     start: 0,
//                   ),
//                   child: TextField(
//                     controller: AppCubit.get(context).textEditingController,
//                     style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                       height: 1.2,
//                     ),
//                     textInputAction: TextInputAction.search,
//                     onSubmitted: (v) {
//                       if(v.isEmpty) {
//                         AppCubit.get(context).getPosts();
//                       } else {
//                         AppCubit.get(context).search();
//                       }
//                     },
//                     onChanged: (v) {
//                       if(v.isEmpty) {
//                         AppCubit.get(context).getPosts();
//                       }
//                     },
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       // hintText: 'search on posts here',
//                       hintStyle: Theme.of(context).textTheme.caption,
//                       prefixIcon: const Icon(
//                         Icons.search,
//                       ),
//                       suffixIcon: AppCubit.get(context)
//                           .textEditingController
//                           .text
//                           .isNotEmpty
//                           ? IconButton(
//                         color: Colors.red,
//                         onPressed: () {
//                           AppCubit.get(context).getPosts();
//                         },
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.black54,
//                         ),
//                       )
//                           : null,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (AppCubit.get(context).posts.isEmpty)
//               const Expanded(child: MyIndicator()),
//             if (AppCubit.get(context).posts.isNotEmpty)
//               Expanded(
//                 child: ListView.separated(
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 0.0,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 8.0,
//                             horizontal: 16.0,
//                           ),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 20.0,
//                                 backgroundColor: Colors.red.shade900,
//                                 child: Text(
//                                   index % 2 == 0 ? 'H' : 'C',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                     color: whiteColor,
//                                     height: 1.3,
//                                   ),
//                                 ),
//                               ),
//                               space10Horizontal(context),
//                               Text(
//                                 index % 2 == 0 ? 'HR' : 'CEO',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle2!
//                                     .copyWith(
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Directionality(
//                                 textDirection: TextDirection.ltr,
//                                 child: Text(
//                                   AppCubit.get(context).posts[index].time,
//                                   style: GoogleFonts.lato(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 10.0,
//                                     color: Colors.grey[500],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // const MyDivider(),
//                         if (AppCubit.get(context).posts[index].text.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8.0,
//                               horizontal: 16.0,
//                             ),
//                             child: SelectableText(
//                               AppCubit.get(context).posts[index].text,
//                               textDirection: normalise(AppCubit.get(context)
//                                   .posts[index]
//                                   .text.characters.first)
//                                   .contains(RegExp(r'[\u0600-\u06FF]'))
//                                   ? TextDirection.rtl
//                                   : TextDirection.ltr,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .subtitle2!
//                                   .copyWith(
//                                 height: 1.2,
//                               ),
//                             ),
//                           ),
//                         if (AppCubit.get(context).posts[index].link.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8.0,
//                               horizontal: 16.0,
//                             ),
//                             child: InkWell(
//                               onTap: () async {
//                                 await launch(
//                                     AppCubit.get(context).posts[index].link);
//                               },
//                               child: SelectableText(
//                                 AppCubit.get(context).posts[index].link,
//                                 textDirection: TextDirection.ltr,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle2!
//                                     .copyWith(
//                                   height: 1.2,
//                                   color: Colors.blue,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         if (AppCubit.get(context)
//                             .posts[index]
//                             .video
//                             .isNotEmpty)
//                           Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: AspectRatio(
//                               aspectRatio: videoPlayerController
//                                   .value
//                                   .aspectRatio,
//                               child: Chewie(
//                                 controller: chewieController,
//                               ),
//                             ),
//                           ),
//                         if (AppCubit.get(context)
//                             .posts[index]
//                             .image
//                             .isNotEmpty &&
//                             AppCubit.get(context).posts[index].image.length ==
//                                 1)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 00,
//                             ),
//                             child: GestureDetector(
//                               onTap: () {
//                                 buildImageDialog(
//                                   context,
//                                   AppCubit.get(context).posts[index].image[0],
//                                 );
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 220,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                       AppCubit.get(context)
//                                           .posts[index]
//                                           .image[0],
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   borderRadius: BorderRadius.circular(
//                                     00,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         if (AppCubit.get(context)
//                             .posts[index]
//                             .image
//                             .isNotEmpty &&
//                             AppCubit.get(context).posts[index].image.length > 1)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                             child: StaggeredGrid.count(
//                               crossAxisCount: 4,
//                               mainAxisSpacing: 4,
//                               crossAxisSpacing: 4,
//                               children: [
//                                 for (int i = 0;
//                                 i <
//                                     AppCubit.get(context)
//                                         .posts[index]
//                                         .image
//                                         .length;
//                                 i++)
//                                   StaggeredGridTile.count(
//                                     crossAxisCellCount: 2,
//                                     mainAxisCellCount: 2,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         buildImageDialog(
//                                           context,
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .image[i],
//                                         );
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                               AppCubit.get(context)
//                                                   .posts[index]
//                                                   .image[i],
//                                             ),
//                                             fit: BoxFit.cover,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             10.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8.0,
//                           ),
//                           child: Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: MaterialButton(
//                                     onPressed: () {
//                                       if (AppCubit.get(context).favMap[
//                                       AppCubit.get(context)
//                                           .posts[index]
//                                           .id] !=
//                                           null) {
//                                         AppCubit.get(context).removeFav(
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .id);
//                                       } else {
//                                         AppCubit.get(context).saveFav(
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .id);
//
//                                         // if (AppCubit.get(context).disFavMap[
//                                         //         AppCubit.get(context)
//                                         //             .posts[index]
//                                         //             .id] ==
//                                         //     null) {
//                                         //   AppCubit.get(context).saveFav(
//                                         //       AppCubit.get(context)
//                                         //           .posts[index]
//                                         //           .id);
//                                         // } else {
//                                         //   Fluttertoast.showToast(
//                                         //     msg: 'you already disliked this post',
//                                         //   );
//                                         // }
//                                       }
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           AppCubit.get(context).favMap[
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .id] ==
//                                               null
//                                               ? Icons.thumb_up_outlined
//                                               : Icons.thumb_up,
//                                           color: AppCubit.get(context).favMap[
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .id] ==
//                                               null
//                                               ? HexColor(darkGreyColor)
//                                               : Colors.red.shade900,
//                                           size: 22.0,
//                                         ),
//                                         // space4Horizontal(context),
//                                         // Text(
//                                         //   'Like',
//                                         //   style: Theme.of(context)
//                                         //       .textTheme
//                                         //       .caption!
//                                         //       .copyWith(
//                                         //         height: 1.2,
//                                         //         color: AppCubit.get(context)
//                                         //                         .favMap[
//                                         //                     AppCubit.get(
//                                         //                             context)
//                                         //                         .posts[index]
//                                         //                         .id] ==
//                                         //                 null
//                                         //             ? HexColor(darkGreyColor)
//                                         //             : Colors.red.shade900,
//                                         //       ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: MaterialButton(
//                                     onPressed: () {
//                                       if (AppCubit.get(context).disFavMap[
//                                       AppCubit.get(context)
//                                           .posts[index]
//                                           .id] !=
//                                           null) {
//                                         AppCubit.get(context).removeDisFav(
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .id);
//                                       } else {
//                                         AppCubit.get(context).saveDisFav(
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .id);
//
//                                         // if (AppCubit.get(context).favMap[
//                                         //         AppCubit.get(context)
//                                         //             .posts[index]
//                                         //             .id] ==
//                                         //     null) {
//                                         //   AppCubit.get(context).saveDisFav(
//                                         //       AppCubit.get(context)
//                                         //           .posts[index]
//                                         //           .id);
//                                         // } else {
//                                         //   Fluttertoast.showToast(
//                                         //     msg: 'you already liked this post',
//                                         //   );
//                                         // }
//                                       }
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           AppCubit.get(context).disFavMap[
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .id] ==
//                                               null
//                                               ? Icons.thumb_down_outlined
//                                               : Icons.thumb_down,
//                                           color: AppCubit.get(context).disFavMap[
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .id] ==
//                                               null
//                                               ? HexColor(darkGreyColor)
//                                               : Colors.red.shade900,
//                                           size: 22.0,
//                                         ),
//                                         // space4Horizontal(context),
//                                         // Text(
//                                         //   'Dislike',
//                                         //   style: Theme.of(context)
//                                         //       .textTheme
//                                         //       .caption!
//                                         //       .copyWith(
//                                         //         height: 1.2,
//                                         //         color: AppCubit.get(context)
//                                         //                         .disFavMap[
//                                         //                     AppCubit.get(
//                                         //                             context)
//                                         //                         .posts[index]
//                                         //                         .id] ==
//                                         //                 null
//                                         //             ? HexColor(darkGreyColor)
//                                         //             : Colors.red.shade900,
//                                         //       ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: MaterialButton(
//                                     onPressed: () async {
//                                       List<String> paths = [];
//
//                                       for (int i = 0;
//                                       i <
//                                           AppCubit.get(context)
//                                               .posts[index]
//                                               .image
//                                               .length;
//                                       i++) {
//                                         final img = await imageFromURL(
//                                             'temp$i',
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .image[i]);
//
//                                         paths.add(img!.path);
//                                       }
//
//                                       Share.shareFiles(
//                                         paths,
//                                         text: AppCubit.get(context)
//                                             .posts[index]
//                                             .text,
//                                       );
//
//                                       // await FlutterShare.shareFile(
//                                       //   title: AppCubit.get(context)
//                                       //       .posts[index]
//                                       //       .text,
//                                       //   text: AppCubit.get(context)
//                                       //       .posts[index]
//                                       //       .text,
//                                       //   filePath: img!.path,
//                                       // );
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           FontAwesomeIcons.share,
//                                           color: HexColor(darkGreyColor),
//                                           size: 22.0,
//                                         ),
//                                         // space4Horizontal(context),
//                                         // Text(
//                                         //   'Share',
//                                         //   style: Theme.of(context)
//                                         //       .textTheme
//                                         //       .caption!
//                                         //       .copyWith(
//                                         //         height: 1.2,
//                                         //         color: HexColor(darkGreyColor),
//                                         //       ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 // Expanded(
//                                 //   child: MaterialButton(
//                                 //     onPressed: () async {
//                                 //       if (AppCubit.get(context).currentComment ==
//                                 //           index) {
//                                 //         AppCubit.get(context).changeComment(-1);
//                                 //       } else {
//                                 //         AppCubit.get(context)
//                                 //             .changeComment(index);
//                                 //       }
//                                 //     },
//                                 //     child: Row(
//                                 //       mainAxisAlignment: MainAxisAlignment.center,
//                                 //       children: [
//                                 //         Icon(
//                                 //           AppCubit.get(context)
//                                 //               .currentComment ==
//                                 //               index
//                                 //               ? FontAwesomeIcons.solidComment : FontAwesomeIcons.comment,
//                                 //           color: AppCubit.get(context)
//                                 //                       .currentComment ==
//                                 //                   index
//                                 //               ? Colors.red.shade900
//                                 //               : HexColor(darkGreyColor),
//                                 //           size: 16.0,
//                                 //         ),
//                                 //         // space4Horizontal(context),
//                                 //         // Text(
//                                 //         //   'Share',
//                                 //         //   style: Theme.of(context)
//                                 //         //       .textTheme
//                                 //         //       .caption!
//                                 //         //       .copyWith(
//                                 //         //         height: 1.2,
//                                 //         //         color: HexColor(darkGreyColor),
//                                 //         //       ),
//                                 //         // ),
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 // IconButton(
//                                 //   onPressed: () {
//                                 //     if (AppCubit.get(context).disFavMap[
//                                 //             AppCubit.get(context)
//                                 //                 .posts[index]
//                                 //                 .id] !=
//                                 //         null) {
//                                 //       AppCubit.get(context).removeFav(
//                                 //           AppCubit.get(context)
//                                 //               .posts[index]
//                                 //               .id);
//                                 //     } else {
//                                 //       AppCubit.get(context).saveFav(
//                                 //           AppCubit.get(context)
//                                 //               .posts[index]
//                                 //               .id);
//                                 //     }
//                                 //   },
//                                 //   icon: Icon(
//                                 //     AppCubit.get(context).favMap[
//                                 //                 AppCubit.get(context)
//                                 //                     .posts[index]
//                                 //                     .id] ==
//                                 //             null
//                                 //         ? Icons.favorite_border_rounded
//                                 //         : Icons.favorite_rounded,
//                                 //     color: Colors.blue,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // if (AppCubit.get(context).commentMap[
//                         // AppCubit.get(context).posts[index].id] !=
//                         //     null &&
//                         //     AppCubit.get(context).currentComment == index)
//                         //   const MyDivider(),
//                         // if (AppCubit.get(context).currentComment == index)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(
//                                 10.0,
//                               ),
//                               border: Border.all(
//                                 width: 1.0,
//                                 color: HexColor(regularGrey),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsetsDirectional.only(
//                                 start: 16.0,
//                               ),
//                               child: TextField(
//                                 minLines: null,
//                                 maxLines: null,
//                                 controller: AppCubit.get(context)
//                                     .commentTextEditingController,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle2!
//                                     .copyWith(
//                                   height: 1.2,
//                                 ),
//                                 onChanged: (v) {
//                                   if(v.isEmpty)
//                                   {
//                                     if(AppCubit.get(context).isRtl) {
//                                       AppCubit.get(context).changeCommentDirection(true);
//                                     } else {
//                                       AppCubit.get(context).changeCommentDirection(false);
//                                     }
//                                   } else if(normalise(v.characters.first).contains(RegExp(r'[\u0600-\u06FF]'))) {
//                                     AppCubit.get(context).changeCommentDirection(true);
//                                   } else {
//                                     AppCubit.get(context).changeCommentDirection(false);
//                                   }
//                                 },
//                                 toolbarOptions: const ToolbarOptions(
//                                   copy: true,
//                                   cut: true,
//                                   paste: true,
//                                   selectAll: true,
//                                 ),
//                                 textDirection: AppCubit.get(context).currentCommentDirection ? TextDirection.rtl : TextDirection.ltr,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: appTranslation(context).addComment,
//                                   hintStyle: Theme.of(context)
//                                       .textTheme
//                                       .caption!
//                                       .copyWith(
//                                     color: HexColor(darkGreyColor),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     onPressed: () {
//                                       if(AppCubit.get(context)
//                                           .commentTextEditingController.text.isNotEmpty) {
//                                         AppCubit.get(context).saveComment(
//                                             AppCubit.get(context)
//                                                 .posts[index]
//                                                 .id);
//                                       } else {
//                                         Fluttertoast.showToast(msg: 'please enter some text in comment',);
//                                       }
//                                     },
//                                     icon: Icon(
//                                       Icons.send,
//                                       color: Colors.red.shade900,
//                                       size: 18.0,
//                                     ),
//                                   ),
//                                 ),
//                                 enableInteractiveSelection: true,
//                               ),
//                             ),
//                           ),
//                         ),
//                         space8Vertical(context),
//                         // const MyDivider(),
//                         if (AppCubit.get(context).commentMap[
//                         AppCubit.get(context).posts[index].id] !=
//                             null)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8.0,
//                               horizontal: 16.0,
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 12.0,
//                                   backgroundColor: Colors.red.shade900,
//                                   child: Text(
//                                     'C',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .caption!
//                                         .copyWith(
//                                       color: whiteColor,
//                                       height: 1.3,
//                                     ),
//                                   ),
//                                 ),
//                                 space10Horizontal(context),
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       for(int i = 0; i < AppCubit.get(context)
//                                           .commentMap[AppCubit.get(context)
//                                           .posts[index]
//                                           .id]!.length ; i++)
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.grey[100],
//                                                 borderRadius: BorderRadius.circular(
//                                                   10.0,
//                                                 ),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color: HexColor(regularGrey),
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: SelectableText(
//                                                   AppCubit.get(context)
//                                                       .commentMap[AppCubit.get(context)
//                                                       .posts[index]
//                                                       .id]![i].comment,
//
//                                                   textDirection: normalise(AppCubit.get(
//                                                       context)
//                                                       .commentMap[
//                                                   AppCubit.get(context)
//                                                       .posts[index]
//                                                       .id]![i].comment.characters.first)
//                                                       .contains(
//                                                       RegExp(r'[\u0600-\u06FF]'))
//                                                       ? TextDirection.rtl
//                                                       : TextDirection.ltr,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .subtitle2!
//                                                       .copyWith(
//                                                     height: 1.2,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             space4Vertical(context),
//                                             Text(
//                                               '11:00 PM 12-03-22',
//                                               textDirection: TextDirection.ltr,
//                                               style: GoogleFonts.lato(
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 10.0,
//                                                 color: Colors.grey[500],
//                                               ),
//                                             ),
//                                             space4Vertical(context),
//                                           ],
//                                         ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         // if (AppCubit.get(context).commentMap[
//                         //         AppCubit.get(context).posts[index].id] !=
//                         //     null)
//                         //   Padding(
//                         //     padding: const EdgeInsets.symmetric(
//                         //       horizontal: 16.0,
//                         //     ),
//                         //     child: Row(
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [
//                         //         Container(
//                         //           width: 24.0,
//                         //         ),
//                         //         space10Horizontal(context),
//                         //         Expanded(
//                         //           child: Container(
//                         //             decoration: BoxDecoration(
//                         //               color: Colors.grey[100],
//                         //               borderRadius: BorderRadius.circular(
//                         //                 10.0,
//                         //               ),
//                         //               border: Border.all(
//                         //                 width: 1.0,
//                         //                 color: HexColor(regularGrey),
//                         //               ),
//                         //             ),
//                         //             child: Padding(
//                         //               padding: const EdgeInsets.all(8.0),
//                         //               child: Text(
//                         //                 AppCubit.get(context)
//                         //                     .commentMap[AppCubit.get(context)
//                         //                         .posts[index]
//                         //                         .id]!
//                         //                     .comment,
//                         //                 textDirection: normalise(AppCubit.get(
//                         //                                 context)
//                         //                             .commentMap[
//                         //                                 AppCubit.get(context)
//                         //                                     .posts[index]
//                         //                                     .id]!
//                         //                             .comment)
//                         //                         .contains(
//                         //                             RegExp(r'[\u0600-\u06FF]'))
//                         //                     ? TextDirection.rtl
//                         //                     : TextDirection.ltr,
//                         //                 style: Theme.of(context)
//                         //                     .textTheme
//                         //                     .subtitle2!
//                         //                     .copyWith(
//                         //                       height: 1.2,
//                         //                     ),
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // if (AppCubit.get(context).commentMap[
//                         //         AppCubit.get(context).posts[index].id] !=
//                         //     null)
//                         //   space8Vertical(context),
//                       ],
//                     ),
//                   ),
//                   separatorBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 14.0,
//                     ),
//                     child: Container(
//                       height: 8.0,
//                       color: Colors.red.shade900,
//                     ),
//                   ),
//                   itemCount: AppCubit.get(context).posts.length,
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }