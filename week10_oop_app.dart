// PC16 - Week 10: Your Turn - Submit Your Enhanced OOP App
// Individual task: inheritance, polymorphism, abstract class, and mixin.

// ---------- ABSTRACT CLASS (contract) ----------
// Any class that implements Reportable MUST provide generateReport().
abstract class Reportable {
  String generateReport();
}

// ---------- MIXIN ----------
// Reusable behavior that can be added to ANY class with "with".
mixin Logger {
  void log(String message) {
    print('[LOG] $message');
  }
}

// ---------- BASE CLASS ----------
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }
}

// ---------- DERIVED CLASS 1 ----------
class Student extends Person with Logger implements Reportable {
  String studentId;
  String course;

  Student(String name, int age, this.studentId, this.course)
      : super(name, age);

  // Polymorphism: overrides introduce() from Person.
  @override
  void introduce() {
    super.introduce();
    print('I am a student. ID: $studentId | Course: $course');
  }

  // Required by the abstract class Reportable.
  @override
  String generateReport() {
    return 'STUDENT REPORT: $name ($studentId) is enrolled in $course.';
  }
}

// ---------- DERIVED CLASS 2 ----------
class Teacher extends Person implements Reportable {
  String employeeId;
  String subject;

  Teacher(String name, int age, this.employeeId, this.subject)
      : super(name, age);

  // Polymorphism: same method name, different behavior.
  @override
  void introduce() {
    super.introduce();
    print('I am a teacher. Employee ID: $employeeId | Teaches: $subject');
  }

  // Required by the abstract class Reportable.
  @override
  String generateReport() {
    return 'TEACHER REPORT: $name ($employeeId) teaches $subject.';
  }
}

// ---------- CLASS OUTSIDE THE MAIN INHERITANCE CHAIN ----------
// Course does not extend Person, but it still shares the Logger mixin.
class Course with Logger {
  String title;
  int units;

  Course(this.title, this.units);

  void enroll(String studentName) {
    log('$studentName enrolled in $title ($units units).');
  }
}

// ---------- MAIN ----------
void main() {
  Student student =
      Student('Ana Reyes', 19, '2026-0042', 'BS Information Technology');
  Teacher teacher = Teacher('Mr. Cruz', 35, 'T-1001', 'Mobile Development');

  // 1. Inheritance + Polymorphism:
  // Both objects are treated as Person, but each introduce() behaves differently.
  print('--- Polymorphism: introduce() ---');
  List<Person> people = [student, teacher];
  for (Person p in people) {
    p.introduce();
    print('');
  }

  // 2. Abstract class: both classes follow the Reportable contract.
  print('--- Abstract class: generateReport() ---');
  List<Reportable> reports = [student, teacher];
  for (Reportable r in reports) {
    print(r.generateReport());
  }

  // 3. Mixin: shared by Student (inside the chain) and Course (outside it).
  print('\n--- Mixin: log() ---');
  student.log('${student.name} logged in.');
  Course course = Course('PC16 Mobile Development', 3);
  course.enroll(student.name);
}
