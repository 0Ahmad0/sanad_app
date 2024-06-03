import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sanad_app/app/controller/users_controller.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/app/widgets/textfield_app.dart';

import '../../app/models/user_model.dart';
import '../../app/widgets/constants_widgets.dart';
import '../widgets/elderly_widget.dart';

class ElderlyManagementAdminScreen extends StatefulWidget {
  const ElderlyManagementAdminScreen({super.key});

  @override
  State<ElderlyManagementAdminScreen> createState() => _ElderlyManagementAdminScreenState();
}

class _ElderlyManagementAdminScreenState extends State<ElderlyManagementAdminScreen> {
  late UsersController controller;
  void initState() {
    controller = Get.put(UsersController());
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s60,
          ),
          Text(
            AppString.elderlyManagement,
            style: StylesManager.textBoldStyle(
              color: ColorManager.primaryColor,
              size: 20.sp,
            ),
          ),
          const DividerAuthWidget(),
          const SizedBox(
            height: AppSize.s10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: TextFiledApp(
              controller: controller.searchController,
              onChanged: (_)=>controller.filterUsers(term: controller.searchController.value.text),
              suffixIcon: false,
              iconData: Icons.search,
              hintText: AppString.search,
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),

          Expanded(
            child: ContainerAuthWidget(
              child:   StreamBuilder<QuerySnapshot>(
               stream: controller.getUsers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return    ConstantsWidgets.circularProgress();
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        ConstantsWidgets.circularProgress();
                        controller.users?.users.clear();

                        if (snapshot.data!.docs!.length > 0) {
                          controller.users?.users =
                              Users.fromJson(snapshot.data!.docs!).users;
                        }
                        controller.filterUsers(term: controller.searchController.value.text);
                        return
                          GetBuilder<UsersController>(
                              builder: (UsersController usersController)=>
                          (controller.usersWithFilter?.users?.isEmpty ?? true)
                            ? ConstantsWidgets.emptyWidget(context,
                            text: "No Users Yet")
                            :

                        buildUsers(context, controller.usersWithFilter?.users ?? []));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: ButtonAppWidget(onPressed: (){}, text: AppString.save),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }
  Widget buildUsers(BuildContext context,List<UserModel> users){
     return

       ListView.builder(
       itemBuilder: (context, index) => ElderlyWidget(
         name: '${users[index].name}',
       ),
       itemCount: users.length,
     );
  }
}

