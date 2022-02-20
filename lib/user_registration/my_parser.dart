// Dr. Frank Kunik ,1drfrankkdo@aol.com&Alexey Podcheko,apodcheko@auis.edu&

void main(){

  String str = 'Frank Kunik,1drfrankkdo@aol.com,& Alexey Podcheko,apodcheko@auis.edu,& John Smith,jsmith@auis.edu';

  //split string
  var arr = str.split(',& ');
  print(str);
  for (int i=0; i<arr.length;i++){arr[i]=arr[i].replaceAll(",", " ");};
 // str=str.replaceAll(",", " ");
  //print(str);
  print(arr);
  var X = [];
  arr.forEach((element) {X.add(element.split(' '));});
  print(X);
  print (X[0][0]);
  print (X[0][1]);
  print (X[2][0]);




  //final str1 = "Dr. Frank Kunik ,1drfrankkdo@aol.com&Alexey Podcheko,apodcheko@auis.edu&";
 // print(str1.split(new RegExp(r'\s')));
}