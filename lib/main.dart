//
//
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/SplassScreen/splasscreen.dart';
import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
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


    return MaterialApp(
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
