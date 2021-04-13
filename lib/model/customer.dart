import 'package:flutter/material.dart';

class Customer {

  final String employee_id;
  final String work_placement;
  final String status_karyawan;
  final String status_ptkp;
  final String lama_bergabung;
  final String lama_bekerja;
  final String bagian;
  final String tgl_bergabung;
  final String job_title;
  final String name;
  final String address;

  const Customer(
      {this.name,
      this.address,
      this.employee_id,
      this.work_placement,
      this.status_karyawan,
      this.status_ptkp,
      this.lama_bekerja,
      this.lama_bergabung,
      this.bagian,
      this.tgl_bergabung,
      this.job_title});
}

