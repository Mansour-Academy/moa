import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/all_requests_model.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/features/my_requests/presentation/widgets/name_item.dart';

import '../../../../core/util/constants.dart';
import 'mobile_pdf.dart';

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
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: HexColor(regularGrey),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // color: HexColor(liteGreyColor),
            borderRadius: BorderRadius.circular(8.0),
            child: ExpansionTile(
              collapsedBackgroundColor: HexColor(liteGreyColor),
              tilePadding: const EdgeInsetsDirectional.only(end: 8.0),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
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
                    // space30Horizontal(context),
                    Expanded(
                      child: Text(
                        model.corrNumber.isNotEmpty
                            ? model.corrNumber
                            : appTranslation(context).noDataFound,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: HexColor(darkGreyColor),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              // NameItem(
              //   title:  appTranslation(context).orderNumber,
              //   desc:   model.corrNumber.isNotEmpty
              //       ? model.corrNumber
              //       : appTranslation(context).noDataFound,
              // ),
              children: <Widget>[
                myDivider(context),
                NameItem(
                  title: appTranslation(context).requestType,
                  desc: getTranslatedText(
                    en: model.corrCategoryTypeNavigation.ename,
                    ar: model.corrCategoryTypeNavigation.aname,
                    context: context,
                  ).isNotEmpty
                      ? getTranslatedText(
                          en: model.corrCategoryTypeNavigation.ename,
                          ar: model.corrCategoryTypeNavigation.aname,
                          context: context,
                        )
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).submissionDate,
                  desc: model.corrDeliveryDate.isNotEmpty
                      ? model.corrDeliveryDate.split('T').first
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).orderStatus,
                  desc: model.reqStatusNavigation.description.isNotEmpty
                      ? model.reqStatusNavigation.description
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).departmentName,
                  desc: getTranslatedText(
                    en: model.corrCategoryTypeNavigation.categoryParent!.ename,
                    ar: model.corrCategoryTypeNavigation.categoryParent!.aname,
                    context: context,
                  ).isNotEmpty
                      ? getTranslatedText(
                          en: model
                              .corrCategoryTypeNavigation.categoryParent!.ename,
                          ar: model
                              .corrCategoryTypeNavigation.categoryParent!.aname,
                          context: context,
                        )
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).responseDate,
                  desc: model.requestReplyDate.isNotEmpty
                      ? model.requestReplyDate.split('T').first
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).attendanceDate,
                  desc: model.citizenReplyDetailsNavigation != null
                      ? model.citizenReplyDetailsNavigation!.attendenceDate
                          .split('T')
                          .first
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                NameItem(
                  title: appTranslation(context).comments,
                  desc: model.citizenReplyDetailsNavigation != null
                      ? model.citizenReplyDetailsNavigation!.requiredComment
                      : appTranslation(context).noDataFound,
                ),
                myDivider(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 38.0,
                    child: MyButton(
                      isLoading: false,
                      onPressed: () async {
                        // AppCubit.get(context).printRequestPDF();
                        final pdfFile =
                            await MobilePDF.generateBodyBDF(model, context);

                        MobilePDF.openFile(pdfFile);
                      },
                      text: appTranslation(context).print,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
