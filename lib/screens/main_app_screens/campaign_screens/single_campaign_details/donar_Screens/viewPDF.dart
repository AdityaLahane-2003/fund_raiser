import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../../components/loading.dart';

class ViewPDF extends StatefulWidget {
  final String url;

  const ViewPDF({super.key, required this.url});

  @override
  State<ViewPDF> createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  PDFDocument? pdfDocument;
  int countdown = 10;
  late Timer timer;

  void initializePDF() async {
    try {
      pdfDocument = await PDFDocument.fromURL(widget.url);
      setState(() {});
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializePDF();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();
        // Redirect back or handle the timeout as needed
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"), 
      ),
      body: pdfDocument == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading(size: 25, color: Colors.black),
            SizedBox(height: 10),
            Text('Loading PDF...'),
            Text('Timeout in $countdown seconds'),
          ],
        ),
      )
          : PDFViewer(document: pdfDocument!),
    );
  }
}
