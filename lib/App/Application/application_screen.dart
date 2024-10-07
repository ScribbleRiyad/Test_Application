
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../Provider/Home/home_provider.dart';
import '../Utils/theme_styles.dart';
import '../Widgets/custom_text_widget.dart';
import 'navigation/widgets/custom_bottom_navigation_bar.dart';


class ApplicationScreen extends ConsumerStatefulWidget {
  const ApplicationScreen({super.key});

  @override
  ConsumerState<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends ConsumerState<ApplicationScreen> {

  final PageStorageBucket bucket = PageStorageBucket();
  dynamic homeScreenProvider;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeScreenProvider = ref.watch(homeScreenController);


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        extendBody: true,
        extendBodyBehindAppBar: true,
        body: PageStorage(
          bucket: bucket,
          child: ref
              .watch(homeScreenController)
              .pageList
              .elementAt(ref.watch(homeScreenController).currentIndex),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,

          child: CustomBottomNavigationBar(
            onTap: (index) {
              switch (index) {
                case 0:
                  setState(() {
                    ref
                        .watch(homeScreenController)
                        .setPageIndex(index: index);
                  });
                  break;

                case 1:
                  setState(() {
                    ref
                        .watch(homeScreenController)
                        .setPageIndex(index: index);

                  });
                  break;

                case 2:
                  setState(() {
                    ref
                        .watch(homeScreenController)
                        .setPageIndex(index: index);

                  });
                  break;

              }
            },
            items: [
              CustomBottomNavigationBarItem(
                  topIcon: ref.watch(homeScreenController).currentIndex == 0
                      ? Container(
                    height: 2,
                    padding: const EdgeInsets.all(10.0),
                    color: ThemeStyles.primary,
                  )
                      : Container(
                    height: 2,
                    padding: const EdgeInsets.all(10.0),

                  ),
                  icon: ref.watch(homeScreenController).currentIndex == 0
                      ? SvgPicture.asset(
                      'assets/Svg/HomeFill.svg',
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                          ThemeStyles.primary, BlendMode.srcIn))
                      : SvgPicture.asset(
                      'assets/Svg/Home.svg',
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                          ThemeStyles.blackColor, BlendMode.srcIn)),
                  title: CustomTextWidget(
                    text: "Home",
                    fontSize: 12,
                    fontWeight:
                    ref.watch(homeScreenController).currentIndex == 0
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color:ref. watch(homeScreenController).currentIndex == 0
                        ? ThemeStyles.primary : ThemeStyles.blackColor,
                  ),
                  bottomIcon:
                  SvgPicture.asset('assets/Svg/play.svg',
                      height: 8,
                      width: 8,
                      colorFilter: ColorFilter.mode(
                          ref.watch(homeScreenController).currentIndex == 0?  ThemeStyles.primary : ThemeStyles.whiteColor, BlendMode.srcIn))
              ),
              CustomBottomNavigationBarItem(
                  topIcon: ref.watch(homeScreenController).currentIndex == 1
                      ? Container(
                    height: 2,
                    padding: const EdgeInsets.all(10.0),
                    color: ThemeStyles.primary,
                  )
                      : Container(
                    height: 2,
                    padding: const EdgeInsets.all(10.0),

                  ),
                  icon: ref.watch(homeScreenController).currentIndex == 1
                      ? SvgPicture.asset(
                      'assets/Svg/CategoryFill.svg',
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                          ThemeStyles.primary, BlendMode.srcIn))
                      : SvgPicture.asset(
                      'assets/Svg/Category.svg',
                      height: 22,
                      width: 22,
                      colorFilter: const ColorFilter.mode(
                          ThemeStyles.blackColor, BlendMode.srcIn)),
                  title: CustomTextWidget(
                    text: "Sensor",
                    fontSize: 12,
                    fontWeight:
                    ref.watch(homeScreenController).currentIndex == 1
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: ref.watch(homeScreenController).currentIndex == 1
                        ? ThemeStyles.primary : ThemeStyles.blackColor,
                  ),
                  bottomIcon:
                  SvgPicture.asset('assets/Svg/play.svg',
                      height: 8,
                      width: 8,
                      colorFilter: ColorFilter.mode(
                          ref.watch(homeScreenController).currentIndex == 1?  ThemeStyles.primary : ThemeStyles.whiteColor, BlendMode.srcIn))
              ),

              CustomBottomNavigationBarItem(
                  topIcon: ref.watch(homeScreenController).currentIndex == 2
                      ? Container(height: 2, padding: const EdgeInsets.all(10.0), color: ThemeStyles.primary,)
                      : Container(height: 2, padding: const EdgeInsets.all(10.0),
                  ),
                  icon: ref.watch(homeScreenController).currentIndex == 2
                      ? SvgPicture.asset('assets/Svg/Userfill.svg', height: 22, width: 22, colorFilter: const ColorFilter.mode(ThemeStyles.primary, BlendMode.srcIn))
                      : SvgPicture.asset('assets/Svg/User.svg', height: 22, width: 22, colorFilter: const ColorFilter.mode(ThemeStyles.blackColor, BlendMode.srcIn)),
                  title: CustomTextWidget(text: "Profile", fontSize: 12, fontWeight:
                  ref.watch(homeScreenController).currentIndex == 2
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: ref.watch(homeScreenController).currentIndex == 2
                        ? ThemeStyles.primary : ThemeStyles.blackColor,
                  ),
                  bottomIcon:
                  SvgPicture.asset('assets/Svg/play.svg',
                      height: 8,
                      width: 8,
                      colorFilter: ColorFilter.mode(
                          ref.watch(homeScreenController).currentIndex == 2?  ThemeStyles.primary : ThemeStyles.whiteColor, BlendMode.srcIn))
              ),

            ],
            selectedIndex: ref.watch(homeScreenController).currentIndex,
            unSelectedColor: ThemeStyles.disabledColor,
            selectedColor: ThemeStyles.primary,
            labelStyle: const TextStyle(fontSize: 16),

          ),
        )
    );
  }
}




