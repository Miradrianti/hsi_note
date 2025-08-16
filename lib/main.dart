
import 'package:aplikasi_catatan/database/db_initializer.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  initDatabaseFactory();
  runApp(MyApp());
}