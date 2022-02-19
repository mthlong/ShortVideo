import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ThankDialog extends StatelessWidget {
  ThankDialog(
      {required Key? key,
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 90.0 + 16.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 16.0,
                  offset: Offset(0.0, 16.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Cảm ơn ",
                  style: AppTextStyle.appTextStyle(
                      context, 24, AppColors.black, FontWeight.w700),
                ),
                SizedBox(height: 16.0),
                Text("Cảm ơn bạn đã góp phần xây dựng ứng dụng ♥️",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        context, 16, AppColors.black, FontWeight.normal)),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      color: AppColors.redButton,
                      onPressed: () {Get.back();  },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            left: 24.0 + 66.0,
            right: 24.0 + 66.0,
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
