// import 'package:http/http.dart';

// var headers = {
//   'Content-Type': 'application/json',
//   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5rIiwidXNlclR5cGUiOiJlbXBsb3llZSIsImVtYWlsIjoibmtAZ21haWwuY29tIiwicGhvbmUiOjg4ODg2NzQ2NTAsImlhdCI6MTY5OTQ0NjIyOSwiZXhwIjoxNjk5NTMyNjI5fQ.KqkvY56rxPM9SxtahbaxXMvvFG6efStNfMk0A7gY_sc'
// };
// var request = http.Request('POST', Uri.parse('http://localhost:2000/app/admin/addAdmin'));
// request.body = json.encode({
//   "FirstName": "Nikhil",
//   "LastName": "Kumar",
//   "Email": "nk@gmail.com",
//   "Password": "12345"
// });
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }
