import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ecnx_ambient_listening/core/constants/app_colors.dart';
import 'package:ecnx_ambient_listening/core/constants/app_text_styles.dart';
import 'package:ecnx_ambient_listening/core/extensions/datetime_extension.dart';
import 'package:ecnx_ambient_listening/core/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;
  final bool needTitle;

  const DatePickerWidget(
      {super.key,
      required this.onDateSelected,
      required this.selectedDate,
      this.needTitle = true});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
    setState(() {});
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
    setState(() {});
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    const extraWidth = 120.0;
    final totalWidth = size.width + extraWidth;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - extraWidth / 2,
        top: offset.dy + size.height + 8,
        width: totalWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(-extraWidth / 2, size.height + 8),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: TableCalendar(
              focusedDay: widget.selectedDate,
              firstDay: DateTime(2000),
              lastDay: DateTime(2150),
              selectedDayPredicate: (day) =>
                  isSameDay(day, widget.selectedDate),
              onDaySelected: (selectedDay, _) {
                widget.onDateSelected(selectedDay);
                _removeOverlay();
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, _) {
                  return DateFormat.yMMMMd().format(date);
                },
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.accentBlue,
                ),
                rightChevronIcon: const Icon(Icons.chevron_right,
                    color: AppColors.accentBlue),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final shortLabels = [
                    'Mo',
                    'Tu',
                    'We',
                    'Th',
                    'Fr',
                    'Sa',
                    'Su'
                  ];
                  final index = (day.weekday + 6) % 7; // So Monday = 0
                  return Center(
                    child: Text(
                      shortLabels[index],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                selectedBuilder: (context, date, _) {
                  return Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: AppColors.bg,
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.accentBlue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${date.day}',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  );
                },
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                defaultTextStyle: context.textTheme.titleMedium!.copyWith(
                  color: AppColors.textBlack,
                ),
                weekendTextStyle: context.textTheme.titleMedium!.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              daysOfWeekHeight: 25,
            ).paddingAll(8),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: _toggleDropdown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(widget.selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: Responsive.isDesktop(context)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
                if (widget.needTitle)
                  Text(
                    '${widget.selectedDate.getWeekDay()}, ${widget.selectedDate.toNameOfMonthAndDay()}',
                    style: Responsive.isDesktop(context)
                        ? AppTextStyles.mediumPx20
                        : AppTextStyles.mediumPx16,
                  ).paddingOnly(bottom: 24),
                SfDateRangePicker(
                  backgroundColor: AppColors.bg,
                  headerStyle: const DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: AppTextStyles.mediumPx16,
                      backgroundColor: AppColors.bg),
                  selectionTextStyle: AppTextStyles.regularPx16,
                  yearCellStyle: const DateRangePickerYearCellStyle(
                    textStyle: AppTextStyles.regularPx16,
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: AppTextStyles.regularPx16,
                  ),
                  viewSpacing: 8,
                  view: DateRangePickerView.month,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  showNavigationArrow: true,
                  selectionColor: AppColors.accentBlue,
                  todayHighlightColor:
                      AppColors.accentBlue.withValues(alpha: 0.5),
                  rangeSelectionColor:
                      AppColors.accentBlue.withValues(alpha: 0.5),
                  selectionMode: DateRangePickerSelectionMode.single,
                  initialSelectedDate: widget.selectedDate,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    widget.onDateSelected(args.value);
                  },
                )
              ]);
  }
}
