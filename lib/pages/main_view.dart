import 'package:flutter/material.dart';
import 'package:mert_karakis_web/core/widgets/app_page.dart';
import 'package:mert_karakis_web/core/widgets/phone.dart';
import 'package:mert_karakis_web/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Responsive(
            desktop: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                width: size.width,
                child: Container(
                  child: Column(
                    children: [Center(child: Text("Mert Karakış"))],
                  ),
                )
                //  Row(
                //   children: const [PhoneCase(), SizedBox(width: 20), AppPage()],
                // ),
                ),
            mobile: Container(
              child: Column(
                children: [Center(child: Text("Mert Karakış"))],
              ),
            ),
            tablet: Container(
              child: Column(
                children: [Center(child: Text("Mert Karakış"))],
              ),
            )));
  }
}
