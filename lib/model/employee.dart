import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String employee_id;
  final String work_placement;
  final String status_karyawan;
  final String status_ptkp;
  final String lama_bergabung;
  final String lama_bekerja;

  const Employee(
      {this.name,
      this.employee_id,
      this.work_placement,
      this.status_karyawan,
      this.status_ptkp,
      this.lama_bekerja,
      this.lama_bergabung
      });
}
