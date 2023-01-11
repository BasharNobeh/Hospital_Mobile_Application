import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patient_app/Provider/Report.dart';
import 'package:patient_app/UI/report_download_page.dart';
import 'package:provider/provider.dart';

import '../Module/AppBar.dart';
import '../Provider/languageProvider.dart';

class ReportSecondPage extends StatelessWidget {
  late List results;
  ReportSecondPage(this.results);
  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);

    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    //  List results =
    //     Provider.of<ReportProvider>(context,listen: true).SelectedResults;
    return Scaffold(
      appBar: MainAppBar(
        title: lang.tReportSecondPage(),
      ),
      body: SafeArea(
          child: Container(
        width: screenWidth,
        height: screenheight,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(11),
                height: screenheight * 0.15,
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: lang.getLanguage() == 'EN'
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            lang.tMyLabatoryResults(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            lang.tDisplayingUpto15Records(),
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 165, 35, 26),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ])
                  ],
                )),
            ...results.map(((e) {
              return ResultsBox(screenheight, screenWidth, context, e["name"],
                  e["date"], e["imageUrl"], e["time"]);
            }))
          ]),
        ),
      )),
    );
  }

  Column ResultsBox(
    double screenheight,
    double screenWidth,
    BuildContext context,
    String name,
    String date,
    String imageUrl,
    String time,
  ) {
    final DMY = date.split(' ');
    var lang = Provider.of<Language>(context, listen: true);
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 167, 167, 167),
                      offset: Offset(1, 0),
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ]),
              width: screenWidth * 0.1,
              height: screenheight * 0.25,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DMY[0],
                      style: const TextStyle(
                          height: 1.2,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DMY[1],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DMY[2],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              width: screenWidth * 0.29,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.41,
              height: screenheight * 0.064,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DownloadPage(imageUrl)),
                    );
                  },
                  child: Text(
                    lang.tViewRestults(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  )),
            )
          ]),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
          color: Colors.black,
        )
      ],
    );
  }
}
