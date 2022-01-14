import 'package:final_app/app/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final int selectedPageIndex;
  final Function onIconTap;

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.06;
    final changeColor = selectedPageIndex == 0 ? AppColors.black : AppColors.white;
    final style = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 11, fontWeight: FontWeight.w600);
    return BottomAppBar(
      color: changeColor,
      child: Container(
        height: barHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomBarNavItem(0, 'Home', style, 'home'),
            _bottomBarNavItem(1, 'Discover', style, 'search'),
            _addVideoNavItem(barHeight),
            _bottomBarNavItem(2, 'Inbox', style, 'message'),
            _bottomBarNavItem(3, 'Profile', style, 'account')
          ],
        ),
      ),
    );
  }

  _bottomBarNavItem(
      int index, String label, TextStyle textStyle, String iconName) {
    bool isSelected = selectedPageIndex == index;
    Color iconAndTextColor = isSelected ? AppColors.black : AppColors.grey;
    if (isSelected && selectedPageIndex == 0) {
      iconAndTextColor = AppColors.white;
    }
    return InkWell(
      onTap: () {
        onIconTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 3,
          ),
          SvgPicture.asset(
            'assets/images/${isSelected ? iconName + '_filled' : iconName}.svg',
            color: iconAndTextColor,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            label,
            style: textStyle.copyWith(color: iconAndTextColor),
          )
        ],
      ),
    );
  }

  _addVideoNavItem(double height) {
    return Container(
      height: height - 18,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient:
            LinearGradient(colors: [AppColors.lightBlue, AppColors.lightPink]),
      ),
      child: Center(
        child: Container(
          width: 39,
          height: height - 18,
          decoration: BoxDecoration(
              color:
                  selectedPageIndex == 0 ? AppColors.white : AppColors.black,
              borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.add_outlined,
            color: selectedPageIndex == 0 ? AppColors.black : AppColors.white,
          ),
        ),
      ),
    );
  }
}
