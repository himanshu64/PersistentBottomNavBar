part of persistent_bottom_nav_bar;

class PersistentBottomNavBar extends StatelessWidget {
  const PersistentBottomNavBar({
    final Key? key,
    this.margin,
    this.confineToSafeArea,
    this.customNavBarWidget,
    this.hideNavigationBar,
    this.onAnimationComplete,
    this.neumorphicProperties = const NeumorphicProperties(),
    this.navBarEssentials,
    this.navBarDecoration,
    this.navBarStyle,
    this.isCustomWidget = false,
  }) : super(key: key);

  final NavBarEssentials? navBarEssentials;
  final EdgeInsets? margin;
  final NavBarDecoration? navBarDecoration;
  final NavBarStyle? navBarStyle;
  final NeumorphicProperties? neumorphicProperties;
  final Widget? customNavBarWidget;
  final bool? confineToSafeArea;
  final bool? hideNavigationBar;
  final Function(bool, bool)? onAnimationComplete;
  final bool? isCustomWidget;

  Padding _navBarWidget() => Padding(
        padding: margin!,
        child: isCustomWidget!
            ? margin!.bottom > 0
                ? SafeArea(
                    top: false,
                    bottom: navBarEssentials!.navBarHeight == 0.0 ||
                            (hideNavigationBar ?? false)
                        ? false
                        : confineToSafeArea ?? true,
                    child: Container(
                      color: navBarEssentials!.backgroundColor,
                      height: navBarEssentials!.navBarHeight,
                      child: customNavBarWidget,
                    ),
                  )
                : Container(
                    color: navBarEssentials!.backgroundColor,
                    child: SafeArea(
                        top: false,
                        bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                (hideNavigationBar ?? false)
                            ? false
                            : confineToSafeArea ?? true,
                        child: SizedBox(
                            height: navBarEssentials!.navBarHeight,
                            child: customNavBarWidget)),
                  )
            : navBarStyle == NavBarStyle.style19
                ? margin!.bottom > 0
                    ? SafeArea(
                        top: false,
                        right: false,
                        left: false,
                        bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                (hideNavigationBar ?? false)
                            ? false
                            : confineToSafeArea ?? true,
                        child: getNavBarStyle(),
                      )
                    : DecoratedBox(
                        decoration: PersistentBottomNavigationBarUtilFunctions
                            .getNavBarDecoration(
                          decoration: navBarDecoration,
                          color: navBarEssentials!.backgroundColor,
                          opacity: navBarEssentials!
                              .items![navBarEssentials!.selectedIndex!].opacity,
                        ),
                        child: SafeArea(
                          top: false,
                          right: false,
                          left: false,
                          bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                  (hideNavigationBar ?? false)
                              ? false
                              : confineToSafeArea ?? true,
                          child: getNavBarStyle(),
                        ),
                      )
                : navBarStyle == NavBarStyle.style15 ||
                        navBarStyle == NavBarStyle.style16
                    ? margin!.bottom > 0
                        ? SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                    (hideNavigationBar ?? false)
                                ? false
                                : confineToSafeArea ?? true,
                            child: DecoratedBox(
                              decoration:
                                  PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                decoration: navBarDecoration,
                                color: navBarEssentials!.backgroundColor,
                                opacity: navBarEssentials!
                                    .items![navBarEssentials!.selectedIndex!]
                                    .opacity,
                              ),
                              child: getNavBarStyle(),
                            ),
                          )
                        : DecoratedBox(
                            decoration:
                                PersistentBottomNavigationBarUtilFunctions
                                    .getNavBarDecoration(
                              decoration: navBarDecoration,
                              color: navBarEssentials!.backgroundColor,
                              opacity: navBarEssentials!
                                  .items![navBarEssentials!.selectedIndex!]
                                  .opacity,
                            ),
                            child: SafeArea(
                              top: false,
                              right: false,
                              left: false,
                              bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                      (hideNavigationBar ?? false)
                                  ? false
                                  : confineToSafeArea ?? true,
                              child: getNavBarStyle(),
                            ),
                          )
                    : DecoratedBox(
                        decoration: PersistentBottomNavigationBarUtilFunctions
                            .getNavBarDecoration(
                          decoration: navBarDecoration,
                          showBorder: false,
                          color: navBarEssentials!.backgroundColor,
                          opacity: navBarEssentials!
                              .items![navBarEssentials!.selectedIndex!].opacity,
                        ),
                        child: ClipRRect(
                          borderRadius: navBarDecoration!.borderRadius ??
                              BorderRadius.zero,
                          child: BackdropFilter(
                            filter: navBarEssentials!
                                    .items![navBarEssentials!.selectedIndex!]
                                    .filter ??
                                ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: DecoratedBox(
                              decoration:
                                  PersistentBottomNavigationBarUtilFunctions
                                      .getNavBarDecoration(
                                showOpacity: false,
                                decoration: navBarDecoration,
                                color: navBarEssentials!.backgroundColor,
                                opacity: navBarEssentials!
                                    .items![navBarEssentials!.selectedIndex!]
                                    .opacity,
                              ),
                              child: SafeArea(
                                top: false,
                                right: false,
                                left: false,
                                bottom: navBarEssentials!.navBarHeight == 0.0 ||
                                        (hideNavigationBar ?? false)
                                    ? false
                                    : confineToSafeArea ?? true,
                                child: getNavBarStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
      );

  @override
  Widget build(final BuildContext context) => hideNavigationBar == null
      ? _navBarWidget()
      : OffsetAnimation(
          hideNavigationBar: hideNavigationBar,
          navBarHeight: navBarEssentials!.navBarHeight,
          onAnimationComplete: (final isAnimating, final isComplete) {
            onAnimationComplete!(isAnimating, isComplete);
          },
          child: _navBarWidget(),
        );

  PersistentBottomNavBar copyWith(
          {final int? selectedIndex,
          final double? iconSize,
          final int? previousIndex,
          final Color? backgroundColor,
          final Duration? animationDuration,
          final List<PersistentBottomNavBarItem>? items,
          final ValueChanged<int>? onItemSelected,
          final double? navBarHeight,
          final EdgeInsets? margin,
          final NavBarStyle? navBarStyle,
          final double? horizontalPadding,
          final NeumorphicProperties? neumorphicProperties,
          final Widget? customNavBarWidget,
          final Function(int)? popAllScreensForTheSelectedTab,
          final bool? popScreensOnTapOfSelectedTab,
          final NavBarDecoration? navBarDecoration,
          final NavBarEssentials? navBarEssentials,
          final bool? confineToSafeArea,
          final ItemAnimationProperties? itemAnimationProperties,
          final Function? onAnimationComplete,
          final bool? hideNavigationBar,
          final bool? isCustomWidget,
          final EdgeInsets? padding}) =>
      PersistentBottomNavBar(
          confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
          margin: margin ?? this.margin,
          neumorphicProperties:
              neumorphicProperties ?? this.neumorphicProperties,
          navBarStyle: navBarStyle ?? this.navBarStyle,
          hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
          customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
          onAnimationComplete:
              onAnimationComplete as dynamic Function(bool, bool)? ??
                  this.onAnimationComplete,
          navBarEssentials: navBarEssentials ?? this.navBarEssentials,
          isCustomWidget: isCustomWidget ?? this.isCustomWidget,
          navBarDecoration: navBarDecoration ?? this.navBarDecoration);

  bool opaque(final int? index) => navBarEssentials!.items == null
      ? true
      : !(navBarEssentials!.items![index!].opacity < 1.0);

  Widget getNavBarStyle() {
    if (isCustomWidget!) {
      return customNavBarWidget ?? const SizedBox.shrink();
    } else {
   

       return BottomNavSimple(
            navBarEssentials: navBarEssentials,
          );
      
    }
  }
}
