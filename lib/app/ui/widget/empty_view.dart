import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class EmptyView extends StatelessWidget {
  final String mess;
  const EmptyView({Key? key, required this.mess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_view.png',
              width:200,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                10,
                0,
                0,
              ),
              child: Text(
                mess,
                style: AppTextStyle.appTextStyle(context, 14, AppColors.black, FontWeight.normal)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
