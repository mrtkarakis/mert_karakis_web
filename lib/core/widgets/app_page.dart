import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_network/image_network.dart';
import 'package:mert_karakis_web/core/widgets/phone.dart';
import 'package:mert_karakis_web/firebase_configurations.dart';
import 'package:mert_karakis_web/global.dart';
import 'package:mert_karakis_web/model/AppPageModel/app_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return Center(child: Observer(builder: (_) {
      return Observer(builder: (_) {
        AppPageModel appPageModel = appPageStore.appPageModel;
        bool hasVideo = appPageModel.videos?.isNotEmpty ?? false;
        bool hasPhoto = appPageModel.photos?.isNotEmpty ?? false;
        bool hasTechnologies = appPageModel.technologies?.isNotEmpty ?? false;
        bool hasDescription = appPageModel.description?.isNotEmpty ?? false;
        AppPageType pageType = setAppPageType(appPageModel.type ?? "aboutMe");

        double width = windowSize.width - PhoneCase.width - 50;
        return SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(appPageModel, context),
              pageType == AppPageType.application
                  ? descriptionAndTechnologiesWidget(width, context,
                      hasDescription, appPageModel, hasTechnologies)
                  : pageType == AppPageType.aboutMe
                      ? Column(
                          children: [
                            contactWidget(context, appPageModel),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                description(width, context, hasDescription,
                                    appPageModel),
                                const SizedBox(width: 12),
                                technologiesWidget(
                                    width,
                                    context,
                                    hasTechnologies,
                                    hasDescription,
                                    appPageModel)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                skillsWidget(width, context, hasTechnologies,
                                    hasDescription, appPageModel),
                                const SizedBox(width: 12),
                                projectsWidget(appPageModel, width),
                              ],
                            )
                          ],
                        )
                      : const SizedBox(),
              pageType == AppPageType.application
                  ? mediaWidget(context, hasVideo)
                  : const SizedBox(),
            ],
          ),
        );
      });
    }));
  }

  Container projectsWidget(AppPageModel appPageModel, double width) {
    PageController pageController = PageController();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.pink.shade300.withOpacity(.3),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text("Projects", style: Theme.of(context).textTheme.titleLarge),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.linear,
                    );
                  },
                  child: Text("Back")),
              SizedBox(
                height: 200,
                width: width - (width / 1.45),
                child: PageView.builder(
                    controller: pageController,
                    itemCount: appPageModel.projects?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, String> project =
                          appPageModel.projects![index]!;
                      return Container(
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              FittedBox(
                                  child: Text(
                                project.keys.first,
                                style: Theme.of(context).textTheme.titleMedium,
                              )),
                              const SizedBox(height: 12),
                              Text(
                                project.values.first,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.7)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              TextButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.linear,
                    );
                  },
                  child: Text("Next")),
            ],
          ),
        ],
      ),
    );
  }

  Container contactWidget(BuildContext context, AppPageModel appPageModel) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.amber.shade300.withOpacity(.3),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Text("Contact", style: Theme.of(context).textTheme.titleLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                launchUrl(Uri(
                  scheme: 'mailto',
                  path: 'mekonyum1@gmail.com',
                  query:
                      'subject=App Feedback&body=App Version 3.23', //add subject and body here
                ));
              },
              child: Row(
                children: [
                  const Text("Mail : "),
                  Text(appPageModel.contact?.mail ?? "")
                ],
              ),
            ),
            Row(
              children: [
                const Text("Phone : "),
                Text(appPageModel.contact?.phone ?? "")
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Center titleWidget(AppPageModel appPageModel, BuildContext context) {
    return Center(
      child: Text(
        appPageModel.title ?? 'Mert Karakis',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Row descriptionAndTechnologiesWidget(double width, BuildContext context,
      bool hasDescription, AppPageModel appPageModel, bool hasTechnologies) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        description(width, context, hasDescription, appPageModel),
        const Spacer(),
        technologiesWidget(
            width, context, hasTechnologies, hasDescription, appPageModel),
      ],
    );
  }

  SizedBox description(double width, BuildContext context, bool hasDescription,
      AppPageModel appPageModel) {
    return SizedBox(
      child: Container(
        width: width / 2 - 10,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade300.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text("Description", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: (hasDescription) ? 12 : 0),
            hasDescription
                ? Text(appPageModel.description ?? "")
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  SizedBox technologiesWidget(double width, BuildContext context,
      bool hasTechnologies, bool hasDescription, AppPageModel appPageModel) {
    return SizedBox(
      child: Container(
        width: width / 2 - 10,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue.shade700.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text("Technologies", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: (hasTechnologies) ? 12 : 0),
            Stack(
              children: [
                hasDescription
                    ? Text(
                        appPageModel.description ?? "",
                        style: TextStyle(color: Colors.transparent),
                      )
                    : const SizedBox(),
                hasTechnologies
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: appPageModel.technologies?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 6.4),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                ".",
                                style: TextStyle(
                                    fontSize: 60, color: Colors.black),
                              ),
                              Text(
                                appPageModel.technologies?[index],
                              ),
                            ],
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox skillsWidget(double width, BuildContext context,
      bool hasTechnologies, bool hasDescription, AppPageModel appPageModel) {
    return SizedBox(
      child: Container(
        width: width / 2 - 10,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.green.shade700.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text("Skills", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: (hasTechnologies) ? 12 : 0),
            Stack(
              children: [
                hasDescription
                    ? Text(
                        appPageModel.description ?? "",
                        style: TextStyle(color: Colors.transparent),
                      )
                    : const SizedBox(),
                hasTechnologies
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: appPageModel.skills?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.done_outline_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 12),
                                  width: width / 2.4,
                                  child: Text(
                                    appPageModel.skills?[index],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Align mediaWidget(BuildContext context, bool hasVideo) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 274,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.purple.shade200.withOpacity(.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Media", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(children: [
              const Spacer(),
              // photosPages(appPageModel: appPageModel),
              hasVideo
                  ? SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: YoutubePlayerIFrame(
                          key: Key(appPageStore
                              .youtubePlayerController!.initialVideoId),
                          controller: appPageStore.youtubePlayerController,
                          aspectRatio: 10 / 16,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ]),
          ],
        ),
      ),
    );
  }

  Widget photosPages({required AppPageModel appPageModel}) {
    PageController pageController = PageController();
    return SizedBox(
      height: 400,
      width: 346,
      child: FutureBuilder(
          future: FirebaseStorage.instanceFor(
                  bucket: Configurations.storageBucket)
              .ref(
                  "${appPageModel.title?.replaceAll(" ", "").toLowerCase() ?? ""}/photos")
              .listAll(),
          builder: (context, AsyncSnapshot<ListResult> snapshot) {
            List<Reference> downloadLinks = [];
            if (snapshot.data != null) {
              downloadLinks = snapshot.data?.items ?? [];
            }
            return PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: downloadLinks.length,
              itemBuilder: (BuildContext context, index) {
                Reference data = downloadLinks[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            pageController.previousPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.linear);
                          },
                          child: Text("back")),
                      FutureBuilder(
                        future: getPhotoData(data),
                        builder: (context, AsyncSnapshot<Map> image) {
                          if (image.data != null) {
                            String downloadLink =
                                image.data!["downloadLink"].toString();
                            return ImageNetwork(
                              image: downloadLink,
                              height: 390,
                              width: 209,
                              fitWeb: BoxFitWeb.fill,
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.linear);
                          },
                          child: Text("next")),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  AppPageType setAppPageType(String type) {
    switch (type.toLowerCase()) {
      case "application":
        return AppPageType.application;
      case "mail":
        return AppPageType.mail;
      case "contacts":
        return AppPageType.contacts;
      case "aboutme":
        return AppPageType.aboutMe;
      case "technologies":
        return AppPageType.technologies;
      case "requestjob":
        return AppPageType.requestJob;
      default:
        return AppPageType.aboutMe;
    }
  }
}

Future<Map> getPhotoData(Reference data) async {
  String downloadLink = await data.getDownloadURL();
  FullMetadata imageData = await data.getMetadata();
  return {"imageData": imageData, "downloadLink": downloadLink};
}

enum AppPageType {
  application,
  mail,
  contacts,
  aboutMe,
  technologies,
  requestJob;
}
