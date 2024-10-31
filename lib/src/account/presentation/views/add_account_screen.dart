import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/account/presentation/bloc/account_bloc.dart';
import 'package:montra_app/src/account/presentation/widgets/account_type.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/add_transaction_background.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  static const routeName = '/addAccount';

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  TextEditingController balanceController = TextEditingController();
  TextEditingController nameAccountController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  final ValueNotifier<bool> showlistIcon = ValueNotifier<bool>(false);
  String imagePick = '';

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(const GetAccountsIconEvent());
  }

  @override
  void dispose() {
    balanceController.dispose();
    nameAccountController.dispose();
    accountTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.addAccountState == SaveState.loading) {
          LoadingDialog.show(context);
        } else if (state.addAccountState == SaveState.error) {
          LoadingDialog.hide(context);
          CoreUtlis.showSnackBar(context, state.errorMessage);
        } else if (state.addAccountState == SaveState.success) {
          LoadingDialog.hide(context);
          Navigator.pop(context);
          CoreUtlis.showSnackBar(context, "تم الحفظ بنجاح");
        }
      },
      child: ValueListenableBuilder(
        valueListenable: showlistIcon,
        builder: (_, bool show, __) {
          return AddTransactionBackground(
            backgroundColor: AppColorsLight.primaryColor,
            valueController: balanceController,
            appBarTitle: context.langauage.addNewAccount,
            bodyTitle: context.langauage.balance,
            changeHeight: showlistIcon,
            children: [
              IField(
                controller: nameAccountController,
                hintText: context.langauage.name,
              ),
              const SizedBox(height: 16),
              IField(
                controller: accountTypeController,
                hintText: context.langauage.accountType,
                readOnly: true,
                suffixIcon: ValueListenableBuilder<bool>(
                  valueListenable: showlistIcon,
                  builder: (_, bool show, __) {
                    return IconButton(
                      onPressed: () {
                        showlistIcon.value = !showlistIcon.value;
                      },
                      icon: Icon(
                        show
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                      ),
                      iconSize: context.width * 0.08,
                      color: AppColorsLight.light20Color,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: show
                    ? AccountType(selectImage: (image) => imagePick = image)
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final balance =
                      double.tryParse(balanceController.text.trim()) ?? 0;

                  context.read<AccountBloc>().add(
                        AddAccountEvent(
                          balance: balance,
                          description: nameAccountController.text.trim(),
                          image: imagePick,
                        ),
                      );
                },
                child: Text(context.langauage.continues),
              ),
              const SizedBox(height: 5),
            ],
          );
        },
      ),
    );
  }
}
