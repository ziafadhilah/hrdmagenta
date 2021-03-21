//
//
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/SplassScreen/splasscreen.dart';
import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/admin/l/home/home.dart';
import 'package:hrdmagenta/page/admin/l/home/navbar.dart';
import 'package:hrdmagenta/page/admin/l/login/admin.dart';
import 'package:hrdmagenta/page/admin/l/project/tabmenu_project.dart';
import 'package:hrdmagenta/page/employee/Account/company_profile.dart';
import 'package:hrdmagenta/page/employee/Home/home.dart';
import 'package:hrdmagenta/page/employee/Home/navbar.dart';
import 'package:hrdmagenta/page/employee/Login/employee.dart';
import 'package:hrdmagenta/page/employee/absence/photoview.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/page/employee/budget/expense.dart';
import 'package:hrdmagenta/page/employee/checkin/maps.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/utalities/color.dart';


//baru

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'HRD ',
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



        //page admin
        'login_admin-page':(context)=>LoginAdmin(),
        'home_admin-page':(context)=>HomeAdmin(),
        'navbar_admin-page':(context)=>NavBarAdmin(),
        'tabs_project_admin-page':(context)=>TabsprojectAdmin(),


      },
      home:SplassScreen(),
    );
  }
}
//
// // import 'package:flutter/material.dart';
// // import 'package:hrdmagenta/model/example.dart';
// // import 'package:hrdmagenta/page/SplassScreen/create.dart';
// // import 'package:hrdmagenta/services/bloc.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(primarySwatch: Colors.orange),
// //       home: MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   MyHomePage({Key key, this.title}) : super(key: key);
// //
// //   final String title;
// //
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   @override
// //   void initState() {
// //     bloc.fetchAllTodo();
// //     super.initState();
// //   }
// //
// //   @override
// //   void dispose() {
// //     bloc.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: StreamBuilder(
// //         stream: bloc.allTodo,
// //         builder: (context, AsyncSnapshot<List<Example>> snapshot) {
// //           if (snapshot.hasData) {
// //             return buildList(snapshot);
// //           } else if (snapshot.hasError) {
// //             return Text(snapshot.error.toString());
// //           }
// //           return Center(child: CircularProgressIndicator());
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //               context, MaterialPageRoute(builder: (context) => Create()));
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// //
// //   Widget buildList(AsyncSnapshot<List<Example>> snapshot) {
// //     return ListView.builder(
// //         itemCount: snapshot.data.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return  CheckboxListTile(
// //             value: true,
// //             title: Text(snapshot.data[index].firstName),
// //             // subtitle: Text(snapshot.data[index].id),
// //             onChanged: (bool isChecked){
// //               bloc.getId(snapshot.data[index].id.toString());
// //               bloc.updateTodo();
// //               bloc.fetchAllTodo();
// //             },
// //           );
// //         });
// //   }
// // }
