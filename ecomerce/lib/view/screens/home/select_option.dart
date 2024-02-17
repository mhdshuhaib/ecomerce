import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/view/widgets/text_widgets.dart';
import 'package:tempauth/viewModel/home_view_model.dart';
import '../../../utils/constants.dart';

class SelectOption extends StatelessWidget {
  const SelectOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<HomeViewModel>(context);
    return Container(
      color: kwhiteColor,
      height: 37,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: home.listItem.length,
        itemBuilder: (context, index) {
          return home.listItem[index].selected
              ? selectedTab(home, index)
              : unSelectedTab(home, index);
        },
      ),
    );
  }

  Padding unSelectedTab(HomeViewModel home, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: home.listItem[index].name == 'All' ? 20 : 0, end: 6),
      child: InkWell(
        onTap: () =>
            home.updateSelectedStatus(selectedName: home.listItem[index].name),
        child: Container(
          height: 37,
          decoration: ShapeDecoration(
            color: const Color(0xFFE6F7EA),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF01AE31)),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 10),
            child: textInter(
              text: home.listItem[index].name,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              fontHeight: 1.25,
              letterSpacing: 0.4,
              color: kprimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Padding selectedTab(HomeViewModel home, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: home.listItem[index].name == 'All' ? 20 : 0, end: 6),
      child: Container(
        height: 37,
        decoration: ShapeDecoration(
          color: const Color(0xFF01AE31),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF01AE31)),
            borderRadius: BorderRadius.circular(100.r),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C01AE31),
              blurRadius: 7,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16, vertical: 10),
          child: textInter(
            text: home.listItem[index].name,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            fontHeight: 1.25.sp,
            letterSpacing: 0.4,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
