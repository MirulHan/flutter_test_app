import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/registry.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../style/colors.dart';
import '../widgets/base_layout.dart';
import '../widgets/primary_column.dart';
import '../widgets/primary_text.dart';
import 'user_details_update_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final int _selectedIndex = 0;
  List<dynamic> contactList = Registry.usersData!;
  RefreshController refreshController = RefreshController();
  Map user = Registry.user!;
  String? search;

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedList = contactList;

    if (search != null && search!.isNotEmpty) {
      displayedList = contactList.where((contact) {
        String firstName = contact['firstName'].toLowerCase();
        String lastName = contact['lastName'].toLowerCase();
        String searchLower = search!.toLowerCase();

        return firstName.contains(searchLower) ||
            lastName.contains(searchLower);
      }).toList();
    }
    return BaseLayout(
      title: 'My Contacts',
      canBack: false,
      bottomNav: BottomNavigation(selectedIndex: _selectedIndex),
      padding: const EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 0.0),
      onpressedActionButton: () {
        Get.to(
          () => const UserUpdateDetailsScreen(),
          transition: Transition.cupertino,
        );
      },
      body: PrimaryColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        gap: 24.0,
        children: [
          SearchBar(
            hintText: 'Search your contact list...',
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              onRefresh: onRefresh,
              header: WaterDropHeader(
                waterDropColor: AppColors.blue,
                complete: PrimaryText(
                  'Refresh Complete',
                  color: AppColors.blue,
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  final contact = displayedList[index];
                  bool currentUser = user['id'] == contact['id'];
                  return GridItem(
                    currentUser: currentUser,
                    contact: contact,
                    onPressed: () => Get.to(
                      () => UserUpdateDetailsScreen(
                        user: contact,
                      ),
                      transition: Transition.cupertino,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await Registry.refreshUserList();
    await Registry.lastUser();
    setState(() {
      inspect(Registry.usersData);
      contactList = Registry.usersData!;
      refreshController.refreshCompleted();
    });
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    this.onChanged,
    this.hintText,
  });

  final Function(String)? onChanged;
  final String? hintText;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FocusNode _focusNode;
  Color _iconColor = AppColors.darkGray;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _iconColor = _focusNode.hasFocus ? AppColors.blue : AppColors.darkGray;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search_rounded,
            color: _iconColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.darkGray,
            fontSize: 12.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.only(
            bottom: 45.0,
            left: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.darkGray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.contact,
    this.currentUser = false,
    this.onPressed,
  });

  final dynamic contact;
  final bool currentUser;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: AppColors.darkGray,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            gap: 8.0,
            children: [
              Expanded(
                child: Center(
                  child: CircleAvatar(
                    radius: double.infinity,
                    backgroundColor: AppColors.blue,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${contact['firstName'][0] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${contact['lastName'][0] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 45.0,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${contact['firstName']} ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blue,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: contact['lastName'],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blue,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      if (currentUser)
                        TextSpan(
                          text: ' (you)',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.darkGray,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
