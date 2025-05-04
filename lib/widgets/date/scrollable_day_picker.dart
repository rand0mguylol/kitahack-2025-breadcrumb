import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResponsiveScrollableDayPicker extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime date) onClickCallback;

  const ResponsiveScrollableDayPicker(
      {Key? key, required this.selectedDate, required this.onClickCallback})
      : super(key: key);

  @override
  _ResponsiveScrollableDayPickerState createState() =>
      _ResponsiveScrollableDayPickerState();
}

class _ResponsiveScrollableDayPickerState
    extends State<ResponsiveScrollableDayPicker> {
  late List<DateTime> weekDates;
  final double itemWidth = 60.0; // fixed width for each day card
  late List<DateTime> monthDates;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    generateMonthDates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToSelectedDate();
    });
    print("CHILD SET STATE");
  }

  @override
  void didUpdateWidget(covariant ResponsiveScrollableDayPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate.month != widget.selectedDate.month ||
        oldWidget.selectedDate.year != widget.selectedDate.year) {
      generateMonthDates();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToSelectedDate();
    });
  }

  void scrollToSelectedDate() {
    final int selectedIndex = widget.selectedDate.day - 1;
    final double targetOffset = selectedIndex * (itemWidth - 20);
    _scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void generateMonthDates() {
    final firstDay =
        DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(
        widget.selectedDate.year, widget.selectedDate.month);

    monthDates = List.generate(daysInMonth, (index) {
      return firstDay.add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Child rebuild");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // optional
      children: [
        SizedBox(
          height: 80,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 0),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: monthDates.length,
              itemBuilder: (builder, index) {
                DateTime date = monthDates[index];
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        DateFormat('E').format(date),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          areDatesEqual(date, widget.selectedDate)
                              ? Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orangeAccent),
                                  child: Text(
                                    DateFormat('d').format(date),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    widget.onClickCallback(date);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(DateFormat('d').format(date)),
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}

bool areDatesEqual(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
