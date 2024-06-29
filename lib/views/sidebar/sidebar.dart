import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_it_admin_web/controllers/sidebarControllers/sidebar_controller.dart';
import 'package:rent_it_admin_web/controllers/sidebarControllers/sidebarstate_controller.dart';
import 'package:rent_it_admin_web/utils/colors.dart';

class SideBarWidgetTest extends StatelessWidget {
  const SideBarWidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SideBarState(),
      child: Consumer<SideBarState>(
        builder: (context, state, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              body: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSideMenu(context, state),
                  ),
                  Expanded(
                    child: PageView(
                      controller: state.pageController,
                      children: context.read<SideBarProvider>().screens,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context, SideBarState state) {
    final provider = context.read<SideBarProvider>();

    return SideMenu(
      style: SideMenuStyle(
        arrowCollapse: containerbg,
        displayMode: SideMenuDisplayMode.auto,
        decoration: const BoxDecoration(),
        openSideMenuWidth: 200,
        compactSideMenuWidth: 55,
        hoverColor: Colors.blue[100],
        selectedColor: Colors.lightBlue,
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.black54,
        backgroundColor: RentItColors.background,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        unselectedTitleTextStyle: const TextStyle(color: Colors.black54),
        iconSize: 20,
        itemBorderRadius: const BorderRadius.all(Radius.circular(5.0)),
        showTooltip: true,
        itemHeight: 50.0,
        itemInnerSpacing: 8.0,
        itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        toggleColor: Colors.black54,
      ),
      showToggle: true,
      controller: state.sideMenuController,
      title: _buildSideMenuTitle(),
      items: _buildSideMenuItems(provider, state),
    );
  }

  Widget _buildSideMenuTitle() {
    return Column(
      children: [
        Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 50,
                maxWidth: 50,
              ),
              child: Image.asset('assets/images/ford.png'),
            ),
          ],
        ),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
      ],
    );
  }

  List<SideMenuItem> _buildSideMenuItems(SideBarProvider provider, SideBarState state) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Dashboard', 'icon': Icons.space_dashboard_rounded, 'tooltip': "Admin Dashboard"},
      {'title': 'Vehicle', 'icon': FontAwesomeIcons.car, 'tooltip': "Vehicle"},
      {'title': 'Category', 'icon': Icons.category_rounded, 'tooltip': "Category"},
      {'title': 'Rentals', 'icon': Icons.car_rental_rounded, 'tooltip': "Rentals"},
      {'title': 'Reviews', 'icon': Icons.reviews_rounded, 'tooltip': "Reviews"},
      {'title': 'Transactions', 'icon': FontAwesomeIcons.ccVisa, 'tooltip': "Transactions"},
      {'title': 'Customers', 'icon': Icons.person, 'tooltip': "Customers"},
      {'title': 'Settings', 'icon': Icons.settings, 'tooltip': "Settings"},
      {'title': 'Help', 'icon': Icons.help_rounded, 'tooltip': "Help & Support"},
      {'title': 'Logout', 'icon': Icons.exit_to_app_rounded, 'tooltip': "Exit"},
    ];

    return menuItems.map((item) {
      return SideMenuItem(
        title: item['title'],
        icon: Icon(item['icon']),
        tooltipContent: item['tooltip'],
        onTap: (index, _) {
          provider.setSelectedIndex(index);
          state.setPage(index);
        },
      );
    }).toList();
  }
}
