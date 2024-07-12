import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:education_project/on_boarding/domain/models/page_content_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    required this.pageContent,
    super.key,
  });

  final PageContentModel pageContent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.fill,
            height: context.height * 0.45,
            pageContent.image,
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Column(
              children: [
                Text(
                  pageContent.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: context.theme.cardColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                Text(
                  pageContent.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: context.theme.cardColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor:
                        context.theme.buttonTheme.colorScheme?.primary,
                    foregroundColor:
                        context.theme.buttonTheme.colorScheme?.onPrimary,
                    minimumSize: Size(context.width * 0.6, 50),
                  ),
                  onPressed: () async {},
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
