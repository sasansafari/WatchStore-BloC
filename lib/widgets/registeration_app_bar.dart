
import 'package:flutter/material.dart';
import 'package:watch_store/component/text_style.dart';

import '../res/strings.dart';

class RegisterationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterationAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:Size(size.width,size.height*.1)
      ,child: Row(
        children: [
          IconButton(onPressed:(() => Navigator.pop(context)), icon: const Icon(Icons.arrow_back)),
    
          const Text(AppStrings.register,style: AppTextStyles.title,)
        ],
      ),
      
       );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(size.height*.1);
}
