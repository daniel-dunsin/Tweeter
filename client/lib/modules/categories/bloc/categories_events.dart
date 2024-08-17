import 'package:flutter/material.dart';

@immutable
sealed class CategoriesEvents {}

class CategoriesRequested extends CategoriesEvents {}
