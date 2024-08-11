import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class DateSelector extends StatefulWidget {
  final DateTime? date;
  final Function(DateTime? date)? onChangeDate;

  DateSelector({super.key, this.date, this.onChangeDate});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Container(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: appColors.secondaryBackgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          widget.onChangeDate!(date);
          setState(() {
            currentDate = date;
          });
        },
        selectedDateTime: currentDate,
        todayButtonColor: appColors.secondaryBackgroundColor,
        todayTextStyle: TextStyle(color: appColors.foregroundColor),
        selectedDayButtonColor: appColors.iconColor,
        daysTextStyle: TextStyle(color: appColors.foregroundColor),
        weekendTextStyle: TextStyle(color: appColors.foregroundColor),
        headerTextStyle: TextStyle(color: appColors.foregroundColor),
        weekdayTextStyle: TextStyle(color: appColors.foregroundColor),
      ),
    );
  }
}
