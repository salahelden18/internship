import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/loading.dart';

import '../../models/coordinator_model.dart';
import '../../widgets/background_linear_gradient.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/main_content_widget.dart';
import '../../widgets/space_height.dart';

class AddMessageScreen extends StatefulWidget {
  const AddMessageScreen({super.key});
  static const String routeName = '/add-message-screen';

  @override
  State<AddMessageScreen> createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends State<AddMessageScreen> {
  String? value;
  final TextEditingController controller = TextEditingController();

  final Set<String> items = {};

  List<CoordinatorModel>? coordinators;

  @override
  void initState() {
    super.initState();
    coordinators = context
        .read<HomeCubit>()
        .dataModel
        ?.internships
        .map((internshipModel) => internshipModel.coordinator)
        .toList();

    if (coordinators != null) {
      items.addAll(coordinators!.map((e) => getNameFromEmail(e.email)).toSet());
    }
  }

  CoordinatorModel? coordinatorModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    icon: Icons.message_outlined,
                    text: 'Add Message',
                  ),
                  const SpaceHeight(),
                  Text(
                    'Contacts:',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black, fontSize: 24),
                  ),
                  const SpaceHeight(height: 10),
                  DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          value = newVal;
                          coordinatorModel = coordinators?.firstWhere(
                              (element) =>
                                  getNameFromEmail(element.email) == value);
                        });
                      }),
                  const SpaceHeight(),
                  Text(
                    'Message:',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black, fontSize: 24),
                  ),
                  const SpaceHeight(height: 10),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: thirdColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: thirdColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: thirdColor),
                      ),
                      hintText: 'Enter Your Message',
                    ),
                    maxLines: 5,
                  ),
                  const SpaceHeight(),
                  Center(
                    child: BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {
                        if (state is AddErrorMessage) {
                          showToast(state.message, Colors.red);
                        } else if (state is AddLoadedMessage) {
                          showToast('Message Sent Successfully', Colors.green);
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddLoadingMessage) {
                          return const Loading();
                        }
                        return MyCustomButton(
                          height: 40,
                          width: 200,
                          text: 'Send',
                          onPress: () {
                            if (controller.text.isEmpty ||
                                coordinatorModel == null) {
                              showToast(
                                  'Please make sure to fill all the fields',
                                  Colors.red);
                            } else {
                              context.read<HomeCubit>().addMessage(
                                  coordinatorModel!.id, controller.text);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      );
}
