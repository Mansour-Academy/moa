import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/all_requests_model.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/widgets/my_button.dart';

import '../../../../core/util/constants.dart';

class MyRequestsItem extends StatelessWidget {
  const MyRequestsItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final AllRequestsDataModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: HexColor(regularGrey),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   color: HexColor(liteGreyColor),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Text(
            //           appTranslation(context).myRequests,
            //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //                 color: blackColor,
            //               ),
            //         ),
            //         // const Spacer(),
            //         // AppTextButton(
            //         //   label: appTranslation(context).view,
            //         //   onPress: (){
            //         //     navigateTo(
            //         //       context,
            //         //       ProductDetailsPage(
            //         //         slug: model.product.slug.en,
            //         //       ),
            //         //     );
            //         //   },
            //         //   style: Theme.of(context).textTheme.subtitle1!,
            //         //   buttonStyle: TextButton.styleFrom(
            //         //     padding: EdgeInsets.zero,
            //         //     alignment: AlignmentDirectional.centerEnd,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            // myDivider(context),
            Container(
              color: HexColor(liteGreyColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).orderNumber,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        model.corrNumber.isNotEmpty?  model.corrNumber : appTranslation(context).noDataFound,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: HexColor(darkGreyColor),
                          fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).requestType,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      getTranslatedText(
                        en: model.corrCategoryTypeNavigation.ename,
                        ar: model.corrCategoryTypeNavigation.aname,
                        context: context,
                      ).isNotEmpty ? getTranslatedText(
                        en: model.corrCategoryTypeNavigation.ename,
                        ar: model.corrCategoryTypeNavigation.aname,
                        context: context,
                      ): appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).submissionDate,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      model.corrDeliveryDate.isNotEmpty? model.corrDeliveryDate.split('T').first : appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                            fontWeight: FontWeight.w400
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).orderStatus,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      model.reqStatusNavigation.description.isNotEmpty? model.reqStatusNavigation.description :  appTranslation(context).noDataFound,

                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).departmentName,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      getTranslatedText(
                        en: model.corrCategoryTypeNavigation.categoryParent!.ename,
                        ar:  model.corrCategoryTypeNavigation.categoryParent!.aname,
                        context: context,
                      ).isNotEmpty ? getTranslatedText(
                        en: model.corrCategoryTypeNavigation.categoryParent!.ename,
                        ar:  model.corrCategoryTypeNavigation.categoryParent!.aname,
                        context: context,
                      ) : appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).responseDate,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      model.requestReplyDate.isNotEmpty? model.requestReplyDate.split('T').first : appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).attendanceDate,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      model.citizenReplyDetailsNavigation != null? model.citizenReplyDetailsNavigation!.attendenceDate.split('T').first : appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appTranslation(context).comments,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      model.citizenReplyDetailsNavigation != null ? model.citizenReplyDetailsNavigation!.requiredComment :  appTranslation(context).noDataFound,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: HexColor(darkGreyColor),
                        fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            // myDivider(context),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //     height: 38.0,
            //     child: MyButton(
            //       isLoading: false,
            //       onPressed: () {
            //       },
            //       text: appTranslation(context).print,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
