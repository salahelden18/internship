import 'dart:io';

import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void createOfficialLetter(String companyName, String email) async {
  final format = DateFormat.yMMMd('en');
  final dateFormated = format.format(DateTime.now());

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Text(
                  dateFormated,
                  textAlign: pw.TextAlign.right,
                ),
              ),
              pw.SizedBox(height: 40),
              pw.Text('To Information Processing Department, $companyName',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(
                '      ${getNameFromEmail(email)}, who has applied to your department for a summer internship, is studying at Üsküdar University, Faculty of Engineering and Natural Sciences, Software Engineering Department. In the Software Engineering department, there are two compulsory internships, one at the end of the second year and the other at the end of third year. The duration of each compulsory internship is 20 working days. Work Accident and Occupational Diseases Insurance Premiums between the dates of internship of the student are covered by our University. The named student has 2 (number of incomplete internships) compulsory internships. This document has been prepared to inform your institution. ',
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Software Engineering Internship Committee Member',
                  textAlign: pw.TextAlign.right,
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Coordinator Name',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ),
            ]); // Center
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/OfficailLetter.pdf");
  await file.writeAsBytes(await pdf.save());

  openFile(file);
}
