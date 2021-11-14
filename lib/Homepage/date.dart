class Date {
  final int day;
  final int month;
  final int year;

  const Date(this.day, this.month, this.year);

  Date.now()
      : day = DateTime.now().day,
        month = DateTime.now().month,
        year = DateTime.now().year;

  @override
  String toString() {
    return month.toString() + '/' + day.toString() + '/' + year.toString();
  }
}
