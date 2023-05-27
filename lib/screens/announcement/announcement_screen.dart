import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/widgets/announcement/announcement_item.dart';
import 'package:internship/widgets/empty_widget.dart';
import 'package:internship/widgets/small_background_linear_gradient.dart';
import 'package:internship/widgets/space_height.dart';
import 'package:intl/intl.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});
  static const String routeName = '/announcement-screen';

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen>
    with SingleTickerProviderStateMixin {
  final format = DateFormat.yMMMd('en');

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final announcementData =
        BlocProvider.of<HomeCubit>(context).dataModel?.announcement;
    return Scaffold(
      body: Column(
        children: [
          const SmallbackgroundLinearGradient(text: 'All Announcements'),
          const SpaceHeight(),
          announcementData!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: EmptyWidget(
                      text: 'No Announcement', imgName: 'annouce.png'),
                )
              : Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) =>
                        SlideTransition(position: _animation, child: child),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: announcementData.length,
                      itemBuilder: (context, index) => AnnouncementItem(
                        text: announcementData[index].title,
                        content: announcementData[index].content,
                        date: format.format(
                          DateTime.parse(announcementData[index].datePublished),
                        ),
                        icon: 'annouce.png',
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
