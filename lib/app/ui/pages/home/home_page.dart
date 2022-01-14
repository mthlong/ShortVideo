import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/ui/widget/home_side_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFollowingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: PageView.builder(
            onPageChanged: (int page) => {print("Page changed to $page")},
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.purple,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            color: Colors.amber,
                          )),
                      Expanded(child: Container(
                        height: MediaQuery.of(context).size.height / 1.75,
                        color: Colors.pink,
                        child: HomeSideBar(),
                      ))
                    ],
                  )
                ],
              );
            }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isFollowingSelected = true;
              });
            },
            child: Text("Following",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 39,
                      ),
                    ],
                    fontWeight: FontWeight.w600,
                    fontSize: _isFollowingSelected ? 18 : 15,
                    color: _isFollowingSelected
                        ? AppColors.white
                        : AppColors.grey)),
          ),
          Text("    |    ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15, color: AppColors.grey)),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFollowingSelected = false;
              });
            },
            child: Text("For you",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 39,
                      ),
                    ],
                    fontWeight: FontWeight.w600,
                    fontSize: !_isFollowingSelected ? 18 : 15,
                    color: !_isFollowingSelected
                        ? AppColors.white
                        : AppColors.grey)),
          ),
        ],
      ),
    );
  }
}
