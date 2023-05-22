import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterCubit.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterStates.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/space_height.dart';

import '../core/global/colors.dart';
import '../core/utils/create_officail_letter.dart';

FloatingActionButton buildFloatingActionButton(
    BuildContext context,
    String email,
    TextEditingController controller,
    String coordinatorName,
    int id) {
  return FloatingActionButton.extended(
    onPressed: () async {
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Company Name',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(letterSpacing: 0),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter Company Name',
                  prefixIcon: Icon(Icons.work),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: thirdColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: thirdColor)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: thirdColor)),
                ),
              ),
              const SpaceHeight(),
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: BlocConsumer<LetterCubit, LetterStates>(
                      listener: (context, state) {
                    if (state is LoadedLetterState) {
                      FocusScope.of(context).unfocus();
                      showToast('Applied Successfully', Colors.green);
                      Navigator.of(context).pop();
                    } else if (state is ErrorLetterState) {
                      FocusScope.of(context).unfocus();

                      showToast(state.message, Colors.red);
                    }
                  }, builder: (context, state) {
                    if (state is LoadingLetterState) {
                      return const Loading();
                    }
                    return MyCustomButton(
                      height: 40,
                      width: 250,
                      text: 'Ask For Official Letter',
                      onPress: () {
                        if (controller.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                              content:
                                  const Text('Please Enter The Company Name'),
                            ),
                          );
                        } else {
                          context
                              .read<LetterCubit>()
                              .letterApply(id, controller.text);
                          // createOfficialLetter(
                          //     controller.text, email, coordinatorName);
                        }
                      },
                    );
                  }),
                ),
              ),
              const SpaceHeight(),
            ],
          ),
        ),
      );
    },
    label: const Text(
      'Official Letter',
    ),
    icon: const Icon(Icons.add_task),
  );
}
