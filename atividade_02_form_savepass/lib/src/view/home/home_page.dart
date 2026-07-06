import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_pass/src/controller/sqlite_password_controller.dart';
import 'package:save_pass/src/view/home/password_list_tile.dart';
import 'package:save_pass/src/view/home/search_text_field.dart';
import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  Widget background() {
    return Column(
      children: [
        Container(
          color: AppColors.primary,
          height: 155,
        ),
        Expanded(
          child: Container(
            color: AppColors.black900,
          ),
        ),
      ],
    );
  }

  Widget header(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.black900,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                width: 48,
                height: 48,
                child: Center(
                  child: Text(
                    "AL",
                    style: AppTextStyle.headline6
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: AppTextStyle.headline5,
                      children: [
                        TextSpan(
                            text: 'Alex Lopes', style: AppTextStyle.headline4),
                      ],
                    ),
                  ),
                  Text('Sinta-se seguro aqui', style: AppTextStyle.subtitle2),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 48,
            height: 48,
            child: IconButton(
              icon: const Icon(Icons.add, color: AppColors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/new_password');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Consumer<SQlitePasswordController>(
              builder: (context, SQlitePasswordController controller, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  header(context),
                  const SizedBox(height: 24),
                  SearchTextField(
                    hintText: 'Qual senha você procura?',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        controller.search(value);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suas senhas',
                        style: AppTextStyle.headline5,
                      ),
                      Text('${controller.passwords.length} senhas',
                          style: AppTextStyle.bodyText2.copyWith(
                            color: AppColors.gray500,
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _searchController.text.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.filteredPasswords.length,
                            itemBuilder: (context, index) {
                              return PasswordListTile(
                                passwordService:
                                    controller.filteredPasswords[index],
                              );
                            },
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.passwords.length,
                            itemBuilder: (context, index) {
                              return PasswordListTile(
                                passwordService: controller.passwords[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
