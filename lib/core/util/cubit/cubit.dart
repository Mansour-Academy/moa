import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/government_model.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/models/post_model.dart';
import 'package:moa/core/models/simple_model.dart';
import 'package:moa/core/network/local/cache_helper.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/translation.dart';
import '../../di/injection.dart';
import '../../models/all_requests_model.dart';
import '../../models/comment_model.dart';
import '../../models/register_model.dart';
import '../../network/repository.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  AppCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static AppCubit get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = true;
  bool isRtlChange = true;

  late ThemeData lightTheme;

  late String family;

  void setThemes({
    required bool rtl,
  }) {
    isRtl = rtl;
    isRtlChange = rtl;

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() {
    family = isRtl ? 'Sofia' : 'Sofia';

    lightTheme = ThemeData(
      // textSelectionTheme: TextSelectionThemeData(
      //   cursorColor: Colors.red,
      //   selectionColor: Colors.green,
      //   selectionHandleColor: Colors.blue,
      // ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
                statusBarColor: Colors.red.shade900,
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 16.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: family,
          fontSize: 22.0,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: Colors.red,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariant),
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariant),
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(15.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(15.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
        ),
        caption: TextStyle(
          fontSize: pxToDp(11.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
        ),
        button: TextStyle(
          fontSize: pxToDp(10.0),
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: whiteColor,
        ),
      ),
    );
  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  void changeLanguage() async {
    isRtl = !isRtl;
    currentCommentDirection = isRtl;

    sl<CacheHelper>().put('isRtl', isRtl);

    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    changeTheme();

    emit(ChangeLanguageState());
  }

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerFullNameController = TextEditingController();
  final registerIdController = TextEditingController();
  final registerMobileController = TextEditingController();
  final registerAddressController = TextEditingController();
  final registerEmailAddressController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final companyDomainController = TextEditingController();

  GovernmentModel? selectedGovernment;

  void changeSelectedGovernment({
    required GovernmentModel value,
  }) {
    selectedGovernment = value;
    emit(ChangeSelectedGovernment());
  }

  PageController pageController = PageController();

  int currentIndex = 0;

  void bottomChanged(int index, context) {
    if (index == 2) {
      showLogoutDialog(
        context: context,
        function: () {
          signOut(
            context,
          );
        },
      );
      return;
    }

    currentIndex = index;

    pageController.jumpToPage(
      index,
    );

    emit(BottomChanged());
  }

  LoginModel? loginModel;

  void userLogin() async {
    emit(UserLoginLoading());

    FirebaseMessaging.instance.getToken().then((value) async {
      final result = await _repository.login(
        companyName: companyDomainController.text,
        firstField: requiredFieldsMap.values.toList()[0].text,
        secondField: requiredFieldsMap.values.toList()[1].text,
        deviceToken: value!,
      );

      result.fold(
        (failure) {
          emit(
            UserLoginError(
              message: failure,
            ),
          );
        },
        (data) {
          loginModel = data;

          emit(UserLoginSuccess(
            token: loginModel!.token,
          ));
        },
      );
    });
  }

  SimpleModel? simpleModel;

  int selectedIndex = -1;

  void like({
    required int postId,
    required int index,
  }) async {
    selectedIndex = index;

    emit(LikeActionLoading(
      postId: postId,
    ));

    final result = await _repository.like(
      postId: postId,
    );

    result.fold(
      (failure) {
        selectedIndex = -1;

        emit(
          LikeActionError(
            message: failure,
          ),
        );
      },
      (data) {
        selectedIndex = -1;

        simpleModel = data;
        posts[index].liked = !posts[index].liked;

        emit(LikeActionSuccess());
      },
    );
  }

  void removeLike({
    required int postId,
    required int index,
  }) async {
    selectedIndex = index;

    emit(LikeActionLoading(
      postId: postId,
    ));

    final result = await _repository.removeLike(
      postId: postId,
    );

    result.fold(
      (failure) {
        selectedIndex = -1;

        emit(
          LikeActionError(
            message: failure,
          ),
        );
      },
      (data) {
        selectedIndex = -1;

        simpleModel = data;
        posts[index].liked = !posts[index].liked;

        emit(LikeActionSuccess());
      },
    );
  }

  int selectedDisLikeIndex = -1;

  void dislike({
    required int postId,
    required int index,
  }) async {
    selectedDisLikeIndex = index;

    emit(DisLikeActionLoading(
      postId: postId,
    ));

    final result = await _repository.dislike(
      postId: postId,
    );

    result.fold(
      (failure) {
        selectedDisLikeIndex = -1;

        emit(
          DisLikeActionError(
            message: failure,
          ),
        );
      },
      (data) {
        selectedDisLikeIndex = -1;

        simpleModel = data;
        posts[index].dislike = !posts[index].dislike;

        emit(DisLikeActionSuccess());
      },
    );
  }

  void removeDisLike({
    required int postId,
    required int index,
  }) async {
    selectedDisLikeIndex = index;

    emit(DisLikeActionLoading(
      postId: postId,
    ));

    final result = await _repository.removeDisLike(
      postId: postId,
    );

    result.fold(
      (failure) {
        selectedDisLikeIndex = -1;

        emit(
          DisLikeActionError(
            message: failure,
          ),
        );
      },
      (data) {
        selectedDisLikeIndex = -1;

        simpleModel = data;
        posts[index].dislike = !posts[index].dislike;

        emit(DisLikeActionSuccess());
      },
    );
  }

  int selectedShareIndex = -1;

  void sharePost({
    required int postId,
    required int index,
    required String source,
  }) async {
    selectedShareIndex = index;

    emit(ShareLoading(
      postId: postId,
    ));

    final result = await _repository.sharePost(
      postId: postId,
      source: source,
    );

    result.fold(
          (failure) {
        selectedShareIndex = -1;

        emit(
          ShareError(
            message: failure,
          ),
        );
      },
          (data) {
        selectedShareIndex = -1;

        simpleModel = data;
        posts[index].isShared = true;

        emit(ShareSuccess());
      },
    );
  }

  int selectedCommentIndex = -1;

  void createNewComment({
    required int postId,
    required int index,
  }) async {
    selectedCommentIndex = index;

    emit(CommentActionLoading(
      postId: postId,
    ));

    final result = await _repository.addComment(
      postId: postId,
      comment: commentTextEditingController.text,
    );

    result.fold(
      (failure) {
        selectedCommentIndex = -1;

        emit(
          CommentActionError(
            message: failure,
          ),
        );
      },
      (data) {
        selectedCommentIndex = -1;

        posts[index].comments.insert(
              0,
              CommentModel(
                id: 0,
                postId: postId,
                comment: commentTextEditingController.text,
                createdOn: DateTime.now().toString(),
              ),
            );

        commentTextEditingController.clear();

        emit(CommentActionSuccess());
      },
    );
  }

  //
  // List<GovernmentModel> governmentsList = [];
  //
  // void getAllGovernments() async {
  //   emit(GetAllGovernmentsLoading());
  //
  //   final result = await _repository.getAllGovernments();
  //
  //   result.fold(
  //     (failure) {
  //       emit(
  //         GetAllGovernmentsError(
  //           message: failure,
  //         ),
  //       );
  //     },
  //     (data) {
  //       governmentsList = data;
  //
  //       selectedGovernment = governmentsList[0];
  //
  //       emit(GetAllGovernmentsSuccess());
  //     },
  //   );
  // }
  //
  // RegisterModel? registerModel;
  //
  // void userRegister() async {
  //   emit(UserRegisterLoading());
  //
  //   final result = await _repository.register(
  //     name: registerFullNameController.text,
  //     email: registerEmailAddressController.text,
  //     mobile: registerMobileController.text,
  //     nationalityId: registerIdController.text,
  //     password: registerPasswordController.text,
  //     cPassword: registerConfirmPasswordController.text,
  //     address: registerAddressController.text,
  //     governorateId: selectedGovernment!.id,
  //   );
  //
  //   result.fold(
  //     (failure) {
  //       emit(
  //         UserRegisterError(
  //           message: failure,
  //         ),
  //       );
  //     },
  //     (data) {
  //       registerModel = data;
  //
  //       emit(UserRegisterSuccess());
  //     },
  //   );
  // }

  List<PostModel> posts = [];

  void getPosts() async {
    if (token!.isNotEmpty) {
      emit(AllPostsLoading());

      final result = await _repository.getPosts();

      result.fold(
        (failure) {
          debugPrint(failure.toString());
          emit(
            AllPostsError(
              message: failure,
            ),
          );
        },
        (data) {
          posts = data;

          emit(AllPostsSuccess());
        },
      );
    }
  }

  bool isLoaded = false;

  void changeLoad({
    required bool load,
  }) {
    isLoaded = load;
    emit(ChangeLoaded());
  }

  TextEditingController textEditingController = TextEditingController();

  // void search() {
  //   posts = posts.where((element) => element.text.toLowerCase().contains(textEditingController.text.toLowerCase()) || element.link.toLowerCase().contains(textEditingController.text.toLowerCase())).toList();
  //
  //   emit(Search());
  // }

  TextEditingController commentTextEditingController = TextEditingController();

  // void saveComment(String id) {
  //   sl<CacheHelper>().get('comments').then((value) {
  //     if (value != null) {
  //       MainCommentModel model = MainCommentModel.fromJson(value);
  //
  //       CommentModel commentModel = CommentModel(
  //         comment: commentTextEditingController.text,
  //         id: id,
  //       );
  //
  //       model.data.add(commentModel);
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'comments',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //         if(commentMap[commentModel.id] == null) {
  //           List<CommentModel> c = [];
  //           c.add(commentModel);
  //
  //           commentMap.addAll({
  //             commentModel.id: c,
  //           });
  //         } else {
  //           List<CommentModel> c = commentMap[commentModel.id]!;
  //           c.add(commentModel);
  //
  //           commentMap.addAll({
  //             commentModel.id: c,
  //           });
  //         }
  //         // commentMap.addAll({
  //         //   commentModel.id: model.data,
  //         // });
  //
  //         print('comment inserted !!!');
  //         emit(Comment());
  //         commentTextEditingController.clear();
  //       });
  //     } else {
  //         List<CommentModel> list = [];
  //
  //         CommentModel commentModel = CommentModel(
  //           comment: commentTextEditingController.text,
  //           id: id,
  //         );
  //
  //         list.add(commentModel);
  //
  //         MainCommentModel model = MainCommentModel(
  //           data: list,
  //         );
  //
  //         sl<CacheHelper>()
  //             .put(
  //           'comments',
  //           model.toJson(),
  //         )
  //             .then((value) {
  //           // if(commentMap[commentModel.id] == null) {
  //           //   List<CommentModel> c = [];
  //           //   c.add(commentModel);
  //           //
  //           //   commentMap.addAll({
  //           //     commentModel.id: c,
  //           //   });
  //           // } else {
  //           //   List<CommentModel> c = commentMap[commentModel.id]!;
  //           //   c.add(commentModel);
  //           //
  //           //   commentMap.addAll({
  //           //     commentModel.id: c,
  //           //   });
  //           // }
  //
  //           commentMap.addAll({
  //             commentModel.id: list,
  //           });
  //
  //           print('comment inserted !!!');
  //           emit(Comment());
  //           commentTextEditingController.clear();
  //         });
  //     }
  //
  //     commentTextEditingController.clear();
  //
  //     emit(Comment());
  //   });
  // }

  Map<String, List<CommentModel>> commentMap = {};

  // void fillCommentMap() {
  //   if (commentsListData != null && commentsListData!.isNotEmpty) {
  //     for (var element in commentsListData!) {
  //       if(commentMap[element.id] == null) {
  //         List<CommentModel> c = [];
  //         c.add(element);
  //
  //         commentMap.addAll({
  //           element.id: c,
  //         });
  //       } else {
  //         List<CommentModel> c = commentMap[element.id]!;
  //         c.add(element);
  //
  //         commentMap.addAll({
  //           element.id: c,
  //         });
  //       }
  //     }
  //
  //     emit(FillCommentMapState());
  //   }
  // }
  //
  // void saveFav(String id) {
  //   sl<CacheHelper>().get('fav').then((value) {
  //     if (value != null) {
  //       MainCommentModel model = MainCommentModel.fromJson(value);
  //
  //       CommentModel commentModel = CommentModel(
  //         comment: 'true',
  //         id: id,
  //       );
  //
  //       model.data.add(commentModel);
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'fav',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //
  //         favMap.addAll({
  //           commentModel.id: commentModel,
  //         });
  //
  //         print('fav inserted !!!');
  //         emit(Comment());
  //       });
  //     } else {
  //       List<CommentModel> list = [];
  //
  //       CommentModel commentModel = CommentModel(
  //         comment: 'true',
  //         id: id,
  //       );
  //
  //       list.add(commentModel);
  //
  //       MainCommentModel model = MainCommentModel(
  //         data: list,
  //       );
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'fav',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //         favMap.addAll({
  //           commentModel.id: commentModel,
  //         });
  //
  //         print('fav inserted !!!');
  //         emit(Comment());
  //       });
  //     }
  //
  //     emit(Comment());
  //   });
  // }
  //
  // void removeFav(String id) {
  //   sl<CacheHelper>().get('fav').then((value) {
  //       List<CommentModel> list = [];
  //
  //       list.removeWhere((element) => element.id == id);
  //
  //       MainCommentModel model = MainCommentModel(
  //         data: list,
  //       );
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'fav',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //         favMap.removeWhere((key, value) => key == id);
  //
  //         print('fav removed !!!');
  //         emit(Comment());
  //       });
  //
  //     emit(Comment());
  //   });
  // }

  Map<String, CommentModel> favMap = {};

  // void fillFavMap() {
  //   if (favListData != null && favListData!.isNotEmpty) {
  //     for (var element in favListData!) {
  //       favMap.addAll({
  //         element.id: element,
  //       });
  //     }
  //
  //     emit(FillCommentMapState());
  //   }
  // }
  //
  // void saveDisFav(String id) {
  //   sl<CacheHelper>().get('disFav').then((value) {
  //     if (value != null) {
  //       MainCommentModel model = MainCommentModel.fromJson(value);
  //
  //       CommentModel commentModel = CommentModel(
  //         comment: 'true',
  //         id: id,
  //       );
  //
  //       model.data.add(commentModel);
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'disFav',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //
  //         disFavMap.addAll({
  //           commentModel.id: commentModel,
  //         });
  //
  //         print('disFav inserted !!!');
  //         emit(Comment());
  //       });
  //     } else {
  //       List<CommentModel> list = [];
  //
  //       CommentModel commentModel = CommentModel(
  //         comment: 'true',
  //         id: id,
  //       );
  //
  //       list.add(commentModel);
  //
  //       MainCommentModel model = MainCommentModel(
  //         data: list,
  //       );
  //
  //       sl<CacheHelper>()
  //           .put(
  //         'disFav',
  //         model.toJson(),
  //       )
  //           .then((value) {
  //         disFavMap.addAll({
  //           commentModel.id: commentModel,
  //         });
  //
  //         print('disFav inserted !!!');
  //         emit(Comment());
  //       });
  //     }
  //
  //     emit(Comment());
  //   });
  // }
  //
  // void removeDisFav(String id) {
  //   sl<CacheHelper>().get('disFav').then((value) {
  //     List<CommentModel> list = [];
  //
  //     list.removeWhere((element) => element.id == id);
  //
  //     MainCommentModel model = MainCommentModel(
  //       data: list,
  //     );
  //
  //     sl<CacheHelper>()
  //         .put(
  //       'disFav',
  //       model.toJson(),
  //     )
  //         .then((value) {
  //       disFavMap.removeWhere((key, value) => key == id);
  //
  //       print('disFav removed !!!');
  //       emit(Comment());
  //     });
  //
  //     emit(Comment());
  //   });
  // }

  Map<String, CommentModel> disFavMap = {};

  // void fillDisFavMap() {
  //   if (disFavListData != null && disFavListData!.isNotEmpty) {
  //     for (var element in disFavListData!) {
  //       disFavMap.addAll({
  //         element.id: element,
  //       });
  //     }
  //
  //     emit(FillCommentMapState());
  //   }
  // }

  int currentComment = -1;

  void changeComment(int value) {
    currentComment = value;

    emit(ChangeCurrentComment());
  }

  bool currentCommentDirection = false;

  void changeCommentDirection(bool value) {
    currentCommentDirection = value;

    emit(ChangeCurrentCommentDirection());
  }

  List<String> requiredFields = [];
  Map<String, TextEditingController> requiredFieldsMap = {};

  void companyDomain() async {
    emit(CompanyDomainLoading());

    final result = await _repository.verifyCompanyDomain(
      domain: companyDomainController.text,
    );

    result.fold(
      (failure) {
        debugPrint(failure.toString());
        emit(
          CompanyDomainError(
            message: failure,
          ),
        );
      },
      (data) {
        requiredFields = [];
        requiredFieldsMap = {};

        requiredFields = data;

        for (var element in requiredFields) {
          debugPrint(element);

          requiredFieldsMap.addAll({
            element: TextEditingController(),
          });
        }

        emit(CompanyDomainSuccess());
      },
    );
  }
//   Future<void> _createPDF() async {
//     PdfDocument document = PdfDocument();
//     document.pages.add();
//
//
//     List<int> bytes = document.save();
//
//     saveAndLaunchFile(bytes, 'Output.pdf');
//
//     emit(PrintRequestPDF());
// }

// Future<void> printRequestPDF() async {
//   final pdf = pw.Document();
//
//   // pdf.addPage(
//   //   pw.Page(
//   //     build: (pw.Context context) => pw.Center(
//   //       child: pw.Text('Hello World!',
//   //       ),
//   //     ),
//   //   ),
//   // );
//
//   // final Uint8List fontData = File('Cairo-Regular.ttf').readAsBytesSync();
//   // final ttf = pw.Font.ttf(fontData.buffer.asByteData());
//   //
//   // pdf.addPage(pw.Page(
//   //     pageFormat: PdfPageFormat.a4,
//   //     build: (pw.Context context) {
//   //       return pw.Center(
//   //         child: pw.Text('Hello World', style: pw.TextStyle(font: ttf, fontSize: 40)),
//   //       ); // Center
//   //     }));
//
//   final font = await PdfGoogleFonts.nunitoExtraLight();
//
//   pdf.addPage(pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text('Hello World', style: pw.TextStyle(font: font, fontSize: 40)),
//         ); // Center
//       }));
//
//
//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
//
//   emit(PrintRequestPDF());
// }
}
