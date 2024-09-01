import 'package:flutter/material.dart';
import 'package:flutter_test_app/registry.dart';
import 'package:flutter_test_app/widgets/base_layout.dart';
import 'package:flutter_test_app/widgets/primary_button.dart';
import 'package:flutter_test_app/widgets/primary_column.dart';
import 'package:flutter_test_app/widgets/primary_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../app.dart';
import '../style/colors.dart';
import '../widgets/primary_text.dart';

class UserUpdateDetailsScreen extends StatefulWidget {
  const UserUpdateDetailsScreen({
    super.key,
    this.user,
  });
  final Map<String, dynamic>? user;

  @override
  State<UserUpdateDetailsScreen> createState() =>
      _UserUpdateDetailsScreenState();
}

class _UserUpdateDetailsScreenState extends State<UserUpdateDetailsScreen> {
  Map<String, String>? errors = {};

  late Map<String, dynamic>? contactInfo = widget.user;
  late bool isCurrentUser =
      widget.user != null ? Registry.user!['id'] == widget.user!['id'] : false;
  late Map<String, dynamic> form = {
    'id': contactInfo?['id'] ?? '',
    'firstName': contactInfo?['firstName'] ?? '',
    'lastName': contactInfo?['lastName'] ?? '',
    'email': contactInfo?['email'] ?? '',
    'phone': contactInfo?['phone'] ?? '',
    'dob': contactInfo?['dob'] ?? '',
  };

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode secondNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();

  @override
  void dispose() {
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Contact Details',
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
      isScrollable: true,
      body: PrimaryColumn(
        gap: 70.0,
        children: [
          PrimaryColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            gap: 24.0,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: AppColors.blue,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: contactInfo != null &&
                                  (contactInfo?['firstName'] != null &&
                                      contactInfo?['firstName'].isNotEmpty) ||
                              (contactInfo?['lastName'] != null &&
                                  contactInfo?['lastName'].isNotEmpty)
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${contactInfo?['firstName'][0] ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 28.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${contactInfo?['lastName'][0] ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 28.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
              PrimaryColumn(
                gap: 12.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        'Main Information',
                        fontSize: 15.0,
                        color: AppColors.blue,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(
                        color: AppColors.lightGray,
                      ),
                    ],
                  ),
                  PrimaryTextField(
                    label: 'First Name',
                    initialValue: form['firstName'],
                    textInputAction: TextInputAction.next,
                    hintText: 'Enter first name.',
                    error: errors?['firstName'],
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.blue,
                    ),
                    onChanged: (value) {
                      form['firstName'] = value;
                    },
                    focusNode: firstNameFocusNode,
                    onEditingComplete: () {
                      firstNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(secondNameFocusNode);
                    },
                  ),
                  PrimaryTextField(
                    label: 'Last Name',
                    textInputAction: TextInputAction.next,
                    initialValue: form['lastName'],
                    hintText: 'Enter last name.',
                    error: errors?['lastName'],
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.blue,
                    ),
                    onChanged: (value) {
                      form['lastName'] = value;
                    },
                    focusNode: secondNameFocusNode,
                    onEditingComplete: () {
                      secondNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                  ),
                ],
              ),
              PrimaryColumn(
                gap: 12.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        'Sub Information',
                        fontSize: 15.0,
                        color: AppColors.blue,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(
                        color: AppColors.lightGray,
                      ),
                    ],
                  ),
                  PrimaryTextField(
                    label: 'Email',
                    textInputAction: TextInputAction.next,
                    hintText: 'Enter email.',
                    initialValue: form['email'],
                    isRequired: false,
                    error: errors?['email'],
                    prefixIcon:
                        Icon(Icons.email_outlined, color: AppColors.blue),
                    onChanged: (value) {
                      form['email'] = value;
                    },
                    focusNode: emailFocusNode,
                    onEditingComplete: () {
                      emailFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(phoneFocusNode);
                    },
                  ),
                  PrimaryTextField(
                    label: 'Phone',
                    textInputAction: TextInputAction.next,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    hintText: 'Enter Phone Number.',
                    initialValue: form['phone'],
                    isRequired: false,
                    error: errors?['phone'],
                    prefixIcon:
                        Icon(Icons.phone_outlined, color: AppColors.blue),
                    onChanged: (value) {
                      form['phone'] = value;
                    },
                    focusNode: phoneFocusNode,
                    onEditingComplete: () {
                      phoneFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(dobFocusNode);
                    },
                  ),
                  PrimaryTextField(
                    label: 'Date of Birth',
                    hintText: 'Enter birthday.',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.datetime,
                    initialValue: form['dob'],
                    isRequired: false,
                    error: errors?['dob'],
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.blue,
                    ),
                    focusNode: dobFocusNode,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                          FocusNode()); // To prevent keyboard from appearing
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          form['dob'] =
                              DateFormat('M/dd/yyyy').format(pickedDate);
                        });
                      }
                    },
                    readOnly: true,
                    onEditingComplete: () {
                      dobFocusNode.unfocus();
                    },
                  ),
                ],
              ),
            ],
          ),
          if (widget.user != null)
            PrimaryColumn(
              gap: 14.0,
              children: [
                PrimaryButton(
                  onPressed: updateDetails,
                  label: 'Update',
                ),
                if (!isCurrentUser)
                  SecondaryButton(
                    onPressed: removeUser,
                    label: 'Remove',
                  ),
              ],
            ),
          if (widget.user == null)
            PrimaryButton(
              onPressed: addUser,
              label: 'Add User',
            ),
        ],
      ),
    );
  }

  Future<void> updateDetails() async {
    setState(() {
      errors = null;
    });

    Map<String, String> localErrors = {};

    if (form['firstName'] == null || form['firstName'].isEmpty) {
      localErrors['firstName'] = 'First name is required.';
    }

    if (form['lastName'] == null || form['lastName'].isEmpty) {
      localErrors['lastName'] = 'Last name is required.';
    }

    if (form['email'] != null && form['email'].isNotEmpty) {
      if (!form['email'].contains('@') || !form['email'].endsWith('.com')) {
        localErrors['email'] = 'Email is invalid.';
      }
    }

    if (form['phone'] != null && form['phone'].isNotEmpty) {
      if (!RegExp(r'^\d{10}$').hasMatch(form['phone'])) {
        localErrors['phone'] = 'Phone number must be 10 digits.';
      }
    }

    if (localErrors.isNotEmpty) {
      setState(() {
        errors = localErrors;
      });
      return;
    }

    await Registry.modifyUserList(form);
    await Registry.lastUser();
    Get.offAll(
      () => const App(),
      transition: Transition.cupertino,
    );
  }

  void removeUser() {
    Registry.removeUserdata(form['id']);
    Get.offAll(
      () => const App(),
      transition: Transition.cupertino,
    );
  }

  void addUser() {
    setState(() {
      errors = null;
    });

    Map<String, String> localErrors = {};

    if (form['firstName'] == null || form['firstName'].isEmpty) {
      localErrors['firstName'] = 'First name is required.';
    }

    if (form['lastName'] == null || form['lastName'].isEmpty) {
      localErrors['lastName'] = 'Last name is required.';
    }

    if (form['email'] != null && form['email'].isNotEmpty) {
      if (!form['email'].contains('@') || !form['email'].endsWith('.com')) {
        localErrors['email'] = 'Email is invalid.';
      }
    }

    if (form['phone'] != null && form['phone'].isNotEmpty) {
      if (!RegExp(r'^\d{10}$').hasMatch(form['phone'])) {
        localErrors['phone'] = 'Phone number must be 10 digits.';
      }
    }

    if (localErrors.isNotEmpty) {
      setState(() {
        errors = localErrors;
      });
      return;
    }
    Registry.addUserList(form);
    Get.offAll(
      () => const App(),
      transition: Transition.cupertino,
    );
  }
}
