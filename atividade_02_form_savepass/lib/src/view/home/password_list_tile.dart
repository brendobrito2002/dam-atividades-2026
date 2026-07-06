import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:save_pass/src/controller/sqlite_password_controller.dart';
import 'package:save_pass/src/model/password_model.dart';
import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/text_styles.dart';
import 'package:provider/provider.dart';

class PasswordListTile extends StatefulWidget {
  PasswordListTile({super.key, required this.passwordService});

  PasswordModel passwordService;
  @override
  State<PasswordListTile> createState() => _PasswordListTileState();
}

class _PasswordListTileState extends State<PasswordListTile> {
  bool isPasswordVisible = false;
  late final String username;
  late final String password;
  late final String service;

  @override
  void initState() {
    username = widget.passwordService.username;
    password = widget.passwordService.password;
    service = widget.passwordService.serviceName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwipeActionCell(
          key: ValueKey(username + service),
          closeWhenScrolling: true,
          leadingActions: [
            SwipeAction(
              title: 'Edit',
              color: Colors.amber,
              onTap: (handler) async {
                await handler(false); // To close the cell
                Navigator.pushNamed(context, '/new_password',
                        arguments: widget.passwordService)
                    .then((value) {
                  if (value != null) {
                    final newPassword = value as PasswordModel;
                    setState(() {
                      username = newPassword.username;
                      password = newPassword.password;
                      service = newPassword.serviceName;
                      widget.passwordService = newPassword;
                    });
                  }
                });
              },
            ),
          ],
          trailingActions: <SwipeAction>[
            SwipeAction(
              title: 'Delete',
              onTap: (CompletionHandler handler) async {
                await handler(true);
                context
                    .read<SQlitePasswordController>()
                    .deletePassword(widget.passwordService);
                setState(() {});
              },
              color: AppColors.red,
              backgroundRadius: 5,
              nestedAction:
                  SwipeNestedAction(title: 'Confirm?', nestedWidth: 130),
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              color: isPasswordVisible ? null : AppColors.black800,
              gradient: isPasswordVisible
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.primary.withOpacity(0.2),
                        AppColors.black800,
                      ],
                    )
                  : null,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color:
                      isPasswordVisible ? AppColors.primary : AppColors.gray500,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              title: AnimatedDefaultTextStyle(
                style: AppTextStyle.bodyText1.copyWith(
                  color:
                      isPasswordVisible ? AppColors.gray200 : AppColors.white,
                  fontSize: isPasswordVisible ? 14 : 16,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(service),
              ),
              subtitle: AnimatedDefaultTextStyle(
                style: AppTextStyle.subtitle2.copyWith(
                  color:
                      isPasswordVisible ? AppColors.primary : AppColors.gray500,
                  fontSize: isPasswordVisible ? 16 : 14,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(
                  isPasswordVisible ? password : username,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
