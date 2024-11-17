import 'package:flutter/material.dart';
import 'package:montra_app/core/common/app/providers/user_info_provider.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/account/data/model/account_model.dart';
import 'package:montra_app/src/account/presentation/utils/account_utils.dart';
import 'package:montra_app/src/account/presentation/views/add_account_screen.dart';
import 'package:montra_app/src/account/presentation/widgets/account_info_card.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.langauage.account,
        ),
      ),
      body: StreamBuilder<List<AccountModel>>(
        stream: AccountUtils.accountStream,
        builder: (_, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(MediaRes.accountBackground),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.langauage.accountBalance,
                        style: context.theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Consumer<UserInfoProvider>(
                        builder: (_, provider, __) {
                          return Text(
                            r'$' '${context.currentUserInfo!.balance}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColorsLight.dark75Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (snapshot.hasData && snapshot.data is List<AccountModel>)
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final account = snapshot.data![index];
                      return AccountInfoCard(
                        image: account.image,
                        description: account.description,
                        onTap: () {},
                        balance: account.balance.toString(),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, AddAccountScreen.routeName),
          child: Text(
            '+ ${context.langauage.addNewWallet}',
          ),
        ),
      ),
    );
  }
}
