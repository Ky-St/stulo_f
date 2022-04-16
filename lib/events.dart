List <Event> events = [];

class Event {
  String employer = "";
  String salary = "";
  String hours = "";
  String result = "";
  String calendar = "";

  Event(this.employer, this.salary, this.hours, this.result, this.calendar);

  Map<String, dynamic> toJson() {
    return {
      'employer': employer,
      'salary': salary,
      'hours': hours,
      'result': result,
      'calendar': calendar
    };
  }
  Event.fromJson(Map<String, dynamic> json) {
    employer = json['employer'];
    salary = json['salary'];
    hours = json['hours'];
    result = json['result'];
    calendar = json['calendar'];
  }
}
