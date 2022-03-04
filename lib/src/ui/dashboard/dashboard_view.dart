import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/dashboard_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.infoDialogBgColor,
                            borderRadius: BorderRadius.circular(18)),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.icTrophy,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 5),
                            Consumer<DashboardViewModel>(
                              builder: (context, model, child) => Text(
                                  model.overallScore.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.infoDialogBgColor,
                            borderRadius: BorderRadius.circular(18)),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.icCoin,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 5),
                            Consumer<DashboardViewModel>(
                              builder: (context, model, child) => Text(
                                  model.totalCoin.toString(),
                                  style: Theme.of(context).textTheme.subtitle1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      context.read<ThemeProvider>().changeTheme();
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? AppAssets.icDarkMode
                            : AppAssets.icLightMode,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 36),
                      Text(
                        "Math Matrix",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Train Your Brain, Improve Your Math Skill",
                        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
                      ),
                      SizedBox(height: 36),
                      DashboardButtonView(
                        dashboard: KeyUtil.dashboardItems[0],
                        position: _offsetLeftEnter,
                        onTab: () {
                          GetIt.I<NavigationService>().navigateTo(
                            KeyUtil.Home,
                            arguments: KeyUtil.dashboardItems[0],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      DashboardButtonView(
                        dashboard: KeyUtil.dashboardItems[1],
                        position: _offsetRightEnter,
                        onTab: () {
                          GetIt.I<NavigationService>().navigateTo(
                            KeyUtil.Home,
                            arguments: KeyUtil.dashboardItems[1],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      DashboardButtonView(
                        dashboard: KeyUtil.dashboardItems[2],
                        position: _offsetLeftEnter,
                        onTab: () {
                          GetIt.I<NavigationService>().navigateTo(
                            KeyUtil.Home,
                            arguments: KeyUtil.dashboardItems[2],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.infoDialogBgColor,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text("Math Matrix by Nividata",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(width: 12),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) => Text("v${snapshot.data?.version}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .crossLightColor)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
