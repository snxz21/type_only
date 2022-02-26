// // Dr. Frank Kunik ,1drfrankkdo@aol.com&Alexey Podcheko,apodcheko@auis.edu&
//
// void main(){
//
//   String str = 'Frank Kunik,1drfrankkdo@aol.com,& Alexey Podcheko,apodcheko@auis.edu,& John Smith,jsmith@auis.edu';
//
//   //split string
//   var arr = str.split(',& ');
//   print(str);
//   for (int i=0; i<arr.length;i++){arr[i]=arr[i].replaceAll(",", " ");};
//  // str=str.replaceAll(",", " ");
//   //print(str);
//   print(arr);
//   var X = [];
//   arr.forEach((element) {X.add(element.split(' '));});
//   print(X);
//   print (X[0][0]);
//   print (X[0][1]);
//   print (X[2][0]);
//
//
//
//
//   //final str1 = "Dr. Frank Kunik ,1drfrankkdo@aol.com&Alexey Podcheko,apodcheko@auis.edu&";
//  // print(str1.split(new RegExp(r'\s')));
// }
void main() {
//   [[Frank, Kunik, 1drfrankkdo@aol.com],
//   [Alexey, Podcheko, apodcheko@auis.edu],
//   [John, Smith, jsmith@auis.edu]]

  List<List<String>> finalParse = [
    ["Frank", "Kunik", "1drfrankkdo@aol.com"],
    ["Alexey", "Podcheko", "apodcheko@auis.edu"],
    ["John", "Smith", "jsmith@auis.edu"],
  ];
  List<Map<String,String>> toFirebase = [
    {
      "firstName": "Frank",
      "lastName": "Kunik",
      "email": "1drfrankkdo@aol.com",
      "password": "sadkljblkajdsbfl",
    },
    {
      "firstName": "Alexey",
      "lastName": "Podcheko",
      "email": "apodcheko@auis.edu",
      "password": "qppdvlsd",
    },
    {
      "firstName": "John",
      "lastName": "Smith",
      "email": "jsmith@auis.edu",
      "password": "sadkljasd11blkajdsbfl",
    },
  ];

  toFirebase.forEach((element) {
    print(element);
  });
}

// import 'dart:io';
// import 'dart:convert';
// class Student {
//   final String name;
//   int age;
//   int course;
//   bool single;
//   List<String> _descriptionList = [];
//   Student(
//       {this.name,
//          this.age,
//          this.course,
//         this.single});
//   void addDescription(String description) {
//     _descriptionList.add(description);
//   }
//   void addAllDescriptions(List<String> descriptions) {
//     _descriptionList.addAll(descriptions);
//   }
//   @override
//   String toString() {
//     var student = 'Студент {имя: $name, возраст: $age, ';
//     student += 'курс: $course, холост: $single, ';
//     student += 'описание: $_descriptionList}';
//     return student;
//   }
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'name': name,
//       'age': age,
//       'course': course,
//       'single': single,
//       'description': _descriptionList
//     };
//   }
// }
//
//
// void main() async {
//   var myFile = File('student.json');
//       var student = Student(name: 'Alex', age: 19, course: 1, single: false);
//   var descriptions = ['Мечтатель', 'Ленив', 'Студент'];
//   student.addAllDescriptions(descriptions);
//   student.addDescription('Постоянно жалуется на жизнь');
//   print(student);
// // Код ниже автоматически вызывает метод toJson у
// // передаваемого на вход экземпляра класса Student
//   var encoder = JsonEncoder.withIndent(' ');
//   print (encoder);
//  myFile.writeAsStringSync(encoder.convert(student));
//   print(myFile.readAsStringSync());
// }