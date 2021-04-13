// //
// //
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/SplassScreen/splasscreen.dart';
import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/admin/l/announcement/ListAnnouncement.dart';
import 'package:hrdmagenta/page/admin/l/home/home.dart';
import 'package:hrdmagenta/page/admin/l/home/navbar.dart';
import 'package:hrdmagenta/page/admin/l/leave/tabmenu_offwork.dart';
import 'package:hrdmagenta/page/admin/l/login/admin.dart';
import 'package:hrdmagenta/page/admin/l/project/tabmenu_project.dart';
import 'package:hrdmagenta/page/employee/Account/company_profile.dart';
import 'package:hrdmagenta/page/employee/Home/home.dart';
import 'package:hrdmagenta/page/employee/Home/navbar.dart';
import 'package:hrdmagenta/page/employee/Login/employee.dart';
import 'package:hrdmagenta/page/employee/absence/photoview.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence_status.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/page/employee/budget/expense.dart';
import 'package:hrdmagenta/page/employee/checkin/maps.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveAdd.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveList.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/page/employee/pyslip/ListPayslip.dart';
import 'package:hrdmagenta/utalities/color.dart';


//baru

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: 'Magenta HRD ',
      color: baseColor,
      debugShowCheckedModeBanner: false,
      //iniliasasi route
      routes: {

        //page employee
        'login_employee-page':(context)=>LoginEmployee(),
        'home_employee-page':(context)=>HomeEmployee(),
        'map_employee-page':(context)=>Maps(),
        'navbar_employee-page':(context)=>NavBarEmployee(),
        'company_profile_employee-page':(context)=>company_pfrofile(),
        'tabmenu_absence_admin':(context)=>TabsAbsenceAdmin(),
        'tabmenu_project-employee':(context)=>Tabsproject(),
        'photoview_employee-page':(context)=>PhotoViewPage(),
        'budget_project_employee-page':(context)=>budgetproject(),
        'expense_budget_employee-page':(context)=>expandbudget(),
        'tabmenu_absence_status_employee-page':(context)=>TabsMenuAbsencestatus(),
        'pyslip_list_employee-page':(context)=>PyslipListPage(),
        'pyslip_list_employe':(context)=>PyslipListPage(),
        'leave_list_employee-page':(context)=>LeaveListEmployee(),
        'leave_add_employee-page':(context)=>LeaveAdd(),
        'Announcement_list_employee-page':(context)=>AnnouncementListEmployee(),


        //page admin
        'login_admin-page':(context)=>LoginAdmin(),
        'home_admin-page':(context)=>HomeAdmin(),
        'navbar_admin-page':(context)=>NavBarAdmin(),
        'tabs_project_admin-page':(context)=>TabsprojectAdmin(),
        'tabmenu_offwork_admin-page':(context)=>TabsMenuOffworkAdmin(),


      },
      home:SplassScreen(),
    );
  }
}
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:hrdmagenta/page/employee/pyslip/PDF.dart';
// //
// //
// // Future main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await SystemChrome.setPreferredOrientations([
// //     DeviceOrientation.portraitUp,
// //     DeviceOrientation.portraitDown,
// //   ]);
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   static final String title = 'Invoice';
// //
// //   @override
// //   Widget build(BuildContext context) => MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     title: title,
// //     theme: ThemeData(primarySwatch: Colors.deepOrange),
// //     home: PdfPage(),
// //   );
// // }
//


// import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("Connection"),
//           ),
//           body: Builder(
//             builder: (BuildContext context) {
//               return OfflineBuilder(
//                 connectivityBuilder: (BuildContext context,
//                     ConnectivityResult connectivity, Widget child) {
//                   final bool connected =
//                       connectivity != ConnectivityResult.none;
//                   return Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       child,
//                       Positioned(
//                         left: 0.0,
//                         right: 0.0,
//                         height: 32.0,
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           color:
//                           connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
//                           child: connected
//                               ?  Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text(
//                                 "OFFLINE",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//
//                             ],
//                           )
//                               : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text(
//                                 "OFFLINE",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               SizedBox(
//                                 width: 8.0,
//                               ),
//                               SizedBox(
//                                 width: 12.0,
//                                 height: 12.0,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2.0,
//                                   valueColor:
//                                   AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 child: Center(
//                   child: Text("ONLINE Or OFFLINE"),
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }