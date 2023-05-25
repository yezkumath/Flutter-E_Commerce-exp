import 'package:e_commer/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  //final int star;
  //final String star_text;
  //final String view;
  //final String desc;
  //final String type;
  //final String location;
  //final String time;

  const AppColumn({ Key? key,
    required this.text
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: text,
                      size: Dimensions.font26
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => 
                          Icon(Icons.star, 
                          color: AppColors.mainColor,
                          size: Dimensions.height15,
                          )),
                        ),
                        SizedBox(width: Dimensions.height10),
                        SmallText(text: "4.5"),
                        SmallText(text: "1287"),
                        SizedBox(width: Dimensions.height10,),
                        SmallText(text: "comments"),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       IconAndTextWidget(
                         icon: Icons.circle_sharp, 
                         iconColor: AppColors.iconColor1, 
                         text: "Normal",
                        ),
                        IconAndTextWidget(
                         icon: Icons.location_on_sharp, 
                         iconColor: AppColors.mainColor, 
                         text: "1.7km",
                        ),
                        IconAndTextWidget(
                         icon: Icons.access_time_sharp, 
                         iconColor: Color.fromARGB(255, 255, 135, 135), 
                         text: "32min",
                        )
                      ],
                    )
                    
                  ],
                );
  }
}