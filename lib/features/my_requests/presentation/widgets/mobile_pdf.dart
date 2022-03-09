import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:moa/features/my_requests/presentation/widgets/name_item.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/models/all_requests_model.dart';
import '../../../../core/util/constants.dart';

class MobilePDF {
  static Future<File> generateBodyBDF(
      AllRequestsDataModel model, context) async {
    final pdf = pw.Document();

    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Cairo-Regular.ttf"));

    var moaIcon = pw.MemoryImage(
      (await rootBundle.load('assets/images/app-icon.png')).buffer.asUint8List(),
    );

    pdf.addPage(pw.Page(
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (contextPDF) => pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Container(
          padding: const pw.EdgeInsets.only(top: 4.0),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(8.0),
            border: pw.Border.all(
                color: PdfColor.fromHex(regularGrey)
            ),
          ),
          child: pw.Column(children: [

            pw.Center(
              child: pw.Image(
                  moaIcon,
                  width: 60.0,
                  height: 60.0
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(model.corrNumber,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                        appTranslation(context).orderNumber.isNotEmpty
                            ? appTranslation(context).orderNumber
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.corrCategoryTypeNavigation.ename.isNotEmpty
                            ? model.corrCategoryTypeNavigation.ename
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).requestType,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.corrDeliveryDate.isNotEmpty
                            ? model.corrDeliveryDate.split('T').first
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).submissionDate,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.reqStatusNavigation.description.isNotEmpty
                            ? model.reqStatusNavigation.description
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).orderStatus,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.corrCategoryTypeNavigation.categoryParent != null
                            ? model
                            .corrCategoryTypeNavigation.categoryParent!.ename
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).departmentName,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.requestReplyDate.isNotEmpty
                            ? model.requestReplyDate.split('T').first
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).responseDate,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.citizenReplyDetailsNavigation != null
                            ? model.citizenReplyDetailsNavigation!.attendenceDate
                            .split('T')
                            .first
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).attendanceDate,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
            pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey),height: 0.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                        model.citizenReplyDetailsNavigation != null
                            ? model.citizenReplyDetailsNavigation!.requiredComment
                            : appTranslation(context).noDataFound,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(appTranslation(context).comments,
                        style: const pw.TextStyle(fontSize: 8.0)),
                  ),
                ],
              ),
            ),
          ],),
        ),

      ),
    ));

    return saveDocument(name: '${model.corrNumber}.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}

// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//   final path = (await getExternalStorageDirectory())?.path;
//   final file = File('$path/$fileName');
//   await file.writeAsBytes(bytes, flush: true);
//   OpenFile.open('$path/$fileName');
// }
