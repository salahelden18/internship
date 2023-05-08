import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/header_widget.dart';
import 'package:internship/widgets/main_content_widget.dart';
import 'package:internship/widgets/space_height.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String routeName = '/about-screen';

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
                children: const [
                  HeaderWidget(icon: Icons.school, text: 'About Us'),
                  SpaceHeight(),
                  Text(
                    'About Our Internship Program: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SpaceHeight(),
                  Text(
                    'Our internship program is designed to provide students with hands-on experience in the field of marketing. Our program offers interns the opportunity to work with a team of experienced professionals and gain practical skills in marketing strategy, content creation, and social media management. We are committed to providing a supportive and engaging learning environment for our interns.If you have any questions about our program, ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ),
                  SpaceHeight(height: 10),
                  Text('please contact us at: '),
                  SpaceHeight(height: 10),
                  Text(
                    'internship@marketingcompany.com.',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  SpaceHeight(height: 10),
                  Text(
                    'We look forward to hearing from you!',
                    style: TextStyle(
                      color: thirdColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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
}
