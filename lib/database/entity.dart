import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(tableName: 'Note')
class Note{
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'Id')
  final int id;

  @ColumnInfo(name: 'Title')
  final String title;
  @ColumnInfo(name: 'Description')
  final String description;
  @ColumnInfo(name: 'Priority')
   final String priority;
  @ColumnInfo(name: 'Date')
  final String date;

  Note(this.title, this.description, this.priority, this.date,[this.id]);

}