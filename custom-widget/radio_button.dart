import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({Key? key,
  required this.onTab,
  required this.title,
  required this.value,
  required this.groupValue}) : super(key: key);
   final Function onTab;
   final String title;
   final int groupValue;
   final int value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.05.sh,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: ()=> onTab(),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 16.0.w),
           Text(title,
                style: Theme.of(context).textTheme.subtitle1
            ),
            Spacer(),
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: value,
              groupValue: groupValue,
              onChanged: (T) =>onTab(),
            ),
            SizedBox(width: 16.0.w),

          ],
        ),
      ),
    );
  }
}
