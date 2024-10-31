import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/views/loading_view.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/account/presentation/bloc/account_bloc.dart';

class AccountType extends StatelessWidget {
  AccountType({required this.selectImage, super.key});

  final void Function(String image) selectImage;
  final ValueNotifier<int> borderIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      buildWhen: (previous, current) =>
          previous.getAccountsIconState != current.getAccountsIconState,
      builder: (context, state) {
        switch (state.getAccountsIconState) {
          case RequestState.loading:
            return const LoadingView(color: AppColorsLight.primaryColor);
          case RequestState.error:
            return Container();
          case RequestState.loaded:
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              itemCount: state.accountsIcon.length,
              itemBuilder: (_, index) {
                return ValueListenableBuilder<int>(
                  valueListenable: borderIndex,
                  builder: (_, imageSelected, __) {
                    final item = state.accountsIcon[index];
                    return GestureDetector(
                      onTap: () {
                        selectImage(item);
                        borderIndex.value = index;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColorsLight.indicatorColor,
                          borderRadius: BorderRadius.circular(8),
                          border: imageSelected == index
                              ? Border.all(
                                  color: AppColorsLight.primaryColor,
                                )
                              : null,
                        ),
                        child: Image.network(item),
                      ),
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}
