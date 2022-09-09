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
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: view(),
        mobile: view(),
        tablet: view(),
      ),
    );
  }

  view() {
    List<AppType> links = AppType.values.toList();

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        width: size.width,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Image.asset(
                  "assets/images/profile_photo.png",
                  height: 99,
                ),
              ),
              const Text("Mert Karakış"),
              const Spacer(),
              SizedBox(
                height: 75,
                width: (80 * links.length).toDouble(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppType.values.length,
                  itemExtent: 80,
                  itemBuilder: (BuildContext context, int index) {
                    final AppType type = AppType.values[index];
                    final String iconPath = type.fullPath();
                    final String name = type.title;
                    final String url = type.url;

                    return TextButton(
                      onPressed: () {
                        type.title.toLowerCase() == 'mail'
                            ? launchUrl(Uri(
                                scheme: 'mailto',
                                path: 'mekonyum1@gmail.com',
                                query:
                                    'subject=App Feedback&body=App Version 3.23', //add subject and body here
                              ))
                            : launchUrl(
                                Uri.parse(
                                  url,
                                ),
                                mode: LaunchMode.platformDefault,
                              );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(iconPath, height: 50),
                          Text(name),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        )
        //  Row(
        //   children: const [PhoneCase(), SizedBox(width: 20), AppPage()],
        // ),
        );
  }
}
