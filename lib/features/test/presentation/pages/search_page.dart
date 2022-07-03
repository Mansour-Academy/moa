// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:moa/core/util/cubit/cubit.dart';
// import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
// import 'package:moa/core/util/widgets/main_scaffold.dart';
// import '../widgets/search_widget.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   @override
//   void initState() {
//     super.initState();
//
//     AppCubit.get(context).getPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MainScaffold(
//       scaffold: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               AppCubit.get(context).getPosts();
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//             ),
//           ),
//           backgroundColor: Colors.red.shade900,
//           title: const Text(
//             'Search',
//           ),
//         ),
//         body: const SafeArea(
//           child: HideKeyboardPage(
//             child: SearchWidget(),
//           ),
//         ),
//       ),
//     );
//   }
// }
