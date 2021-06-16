
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hrdmagenta/page/SplassScreen/splasscreen.dart';
// import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
// import 'package:hrdmagenta/page/admin/l/announcement/ListAnnouncement.dart';
// import 'package:hrdmagenta/page/admin/l/home/home.dart';
// import 'package:hrdmagenta/page/admin/l/home/navbar.dart';
// import 'package:hrdmagenta/page/admin/l/leave/tabmenu_offwork.dart';
// import 'package:hrdmagenta/page/admin/l/login/admin.dart';
// import 'package:hrdmagenta/page/admin/l/project/tabmenu_project.dart';
// import 'package:hrdmagenta/page/employee/Account/company_profile.dart';
// import 'package:hrdmagenta/page/employee/Home/home.dart';
// import 'package:hrdmagenta/page/employee/Home/navbar.dart';
// import 'package:hrdmagenta/page/employee/Login/employee.dart';
// import 'package:hrdmagenta/page/employee/absence/photoview.dart';
// import 'package:hrdmagenta/page/employee/absence/tabmenu_absence_status.dart';
// import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
// import 'package:hrdmagenta/page/employee/budget/expense.dart';
// import 'package:hrdmagenta/page/employee/checkin/maps.dart';
// import 'package:hrdmagenta/page/employee/leave/LeaveAdd.dart';
// import 'package:hrdmagenta/page/employee/leave/LeaveList.dart';
// import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
// import 'package:hrdmagenta/page/employee/pyslip/ListPayslip.dart';
// import 'package:hrdmagenta/utalities/color.dart';
//
//
// //baru
//
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return GetMaterialApp(
//       title: 'Magenta HRD ',
//       color: baseColor,
//       debugShowCheckedModeBanner: false,
//       //iniliasasi route
//       routes: {
//         //page employee
//         'login_employee-page':(context)=>LoginEmployee(),
//         'home_employee-page':(context)=>HomeEmployee(),
//         'map_employee-page':(context)=>Maps(),
//         'navbar_employee-page':(context)=>NavBarEmployee(),
//         'company_profile_employee-page':(context)=>company_pfrofile(),
//         'tabmenu_absence_admin':(context)=>TabsAbsenceAdmin(),
//         'tabmenu_project-employee':(context)=>Tabsproject(),
//         'photoview_employee-page':(context)=>PhotoViewPage(),
//         'budget_project_employee-page':(context)=>budgetproject(),
//         'expense_budget_employee-page':(context)=>expandbudget(),
//         'tabmenu_absence_status_employee-page':(context)=>TabsMenuAbsencestatus(),
//         'pyslip_list_employee-page':(context)=>PyslipListPage(),
//         'pyslip_list_employe':(context)=>PyslipListPage(),
//         'leave_list_employee-page':(context)=>LeaveListEmployee(),
//         'leave_add_employee-page':(context)=>LeaveAdd(),
//         'Announcement_list_employee-page':(context)=>AnnouncementListEmployee(),
//
//
//         //page admin
//         'login_admin-page':(context)=>LoginAdmin(),
//         'home_admin-page':(context)=>HomeAdmin(),
//         'navbar_admin-page':(context)=>NavBarAdmin(),
//         'tabs_project_admin-page':(context)=>TabsprojectAdmin(),
//         'tabmenu_offwork_admin-page':(context)=>TabsMenuOffworkAdmin(),
//
//
//       },
//       home:SplassScreen(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// void main() {
//   return runApp(MyApp());
// }
//
// /// My app class to display the date range picker
// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// /// State for MyApp
// class MyAppState extends State<MyApp> {
//   String _selectedDate = '';
//   String _dateCount = '';
//   String _range = '';
//   String _rangeCount = '';
//
//   /// The method for [DateRangePickerSelectionChanged] callback, which will be
//   /// called whenever a selection changed on the date picker widget.
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     /// The argument value will return the changed date as [DateTime] when the
//     /// widget [SfDateRangeSelectionMode] set as single.
//     ///
//     /// The argument value will return the changed dates as [List<DateTime>]
//     /// when the widget [SfDateRangeSelectionMode] set as multiple.
//     ///
//     /// The argument value will return the changed range as [PickerDateRange]
//     /// when the widget [SfDateRangeSelectionMode] set as range.
//     ///
//     /// The argument value will return the changed ranges as
//     /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
//     /// multi range.
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range =
//             DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
//                 ' - ' +
//                 DateFormat('dd/MM/yyyy')
//                     .format(args.value.endDate ?? args.value.startDate)
//                     .toString();
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('DatePicker demo'),
//             ),
//             body: Stack(
//               children: <Widget>[
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 0,
//                   height: 80,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Selected date: ' + _selectedDate),
//                       Text('Selected date count: ' + _dateCount),
//                       Text('Selected range: ' + _range),
//                       Text('Selected ranges count: ' + _rangeCount)
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   top: 80,
//                   right: 0,
//                   bottom: 0,
//                   child: SfDateRangePicker(
//                     onSelectionChanged: _onSelectionChanged,
//                     selectionMode: DateRangePickerSelectionMode.multiple,
//                     initialSelectedRange: PickerDateRange(
//                         DateTime.now().subtract(const Duration(days: 4)),
//                         DateTime.now().add(const Duration(days: 3))),
//                   ),
//                 )
//               ],
//             )
//             )
//             );
//   }
// }