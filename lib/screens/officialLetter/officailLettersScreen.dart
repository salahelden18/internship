import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/download_file.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/models/letter_model.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterCubit.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterStates.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/space_height.dart';

class OfficailLetterScreen extends StatefulWidget {
  const OfficailLetterScreen({super.key});
  static const String routeName = '/officail-letter-screen';

  @override
  State<OfficailLetterScreen> createState() => _OfficailLetterScreenState();
}

class _OfficailLetterScreenState extends State<OfficailLetterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LetterCubit>().getAllLetetrs();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Offical Letters',
          style: TextStyle(
            fontSize: 18,
            color: thirdColor,
          ),
        ),
        actions: [
          IconButtonWidget(
              icon: Icons.home_outlined,
              onPress: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/');
              }),
        ],
      ),
      body: BlocBuilder<LetterCubit, LetterStates>(builder: (context, state) {
        if (state is GetLoadingLettersState) {
          return const Loading();
        } else if (state is GetErrorLetterState) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        }
        final request = context.read<LetterCubit>().requets;
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) => Column(
            children: [
              ListTile(
                title: Text(request[index].internshipName ?? 'Error',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: width <= 320 ? 16 : 24)),
                subtitle: Text(request[index].companyName ?? 'Error'),
                trailing: _buildStatus(request[index]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    width: 1.5,
                    color: thirdColor,
                  ),
                ),
              ),
              const SpaceHeight(),
            ],
          ),
          itemCount: request.length,
        );
      }),
    );
  }

  Widget _buildStatus(LetterModel model) {
    switch (model.status) {
      case 0:
        return const Text(
          'Under Review',
          style: TextStyle(
            color: thirdColor,
            fontWeight: FontWeight.bold,
          ),
        );
      case 1:
        return TextButton(
          onPressed: () async {
            if (model.officialLetter == null) {
              showToast('The File is Not Uploaded', Colors.red);
            }
            showToast('Downloading', Colors.orange);
            File file = await downloadFile(model.officialLetter!);
            showToast('Downloaded', Colors.green);

            openFile(file);
          },
          child: const Text(
            'See File',
            style: TextStyle(
              color: thirdColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case 2:
        return const Text(
          'Rejected',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      default:
        return const Text('Contact us');
    }
  }
}
