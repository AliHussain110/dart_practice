// The following exercise is a failing unit test that contains partially completed code snippets. Your task is to complete the exercise by writing code to make the tests pass. You don't need to implement main().

// To simulate asynchronous operations, call the following functions, which are provided for you:

// Function	Type signature	Description
// fetchRole()	Future<String> fetchRole()	Gets a short description of the user's role.
// fetchLoginAmount()	Future<int> fetchLoginAmount()	Gets the number of times a user has logged in.
// Part 1: reportUserRole()
// #
// Add code to the reportUserRole() function so that it does the following:

// Returns a future that completes with the following string: "User role: <user role>"
// Note: You must use the actual value returned by fetchRole(); copying and pasting the example return value won't make the test pass.
// Example return value: "User role: tester"
// Gets the user role by calling the provided function fetchRole().
// Part 2: reportLogins()
// #
// Implement an async function reportLogins() so that it does the following:

// Returns the string "Total number of logins: <# of logins>".
// Note: You must use the actual value returned by fetchLoginAmount(); copying and pasting the example return value won't make the test pass.
// Example return value from reportLogins(): "Total number of logins: 57"
// Gets the number of logins by calling the provided function fetchLoginAmount().

// Part 1
// Call the provided async function fetchRole()
// to return the user role.
Future<String> reportUserRole() async {
  // TODO: Implement the reportUserRole function here.
  print('getting user role');
  var userRole = await fetchRole();
  return "User role: $userRole";
    
}

// Part 2
// TODO: Implement the reportLogins function here.
// Call the provided async function fetchLoginAmount()
// to return the number of times that the user has logged in.
Future<String >reportLogins() async{
  print('fetching user Logins');
  var loginReports = await fetchLoginAmount();
  return 'Total number of logins: $loginReports';
  
}

// The following functions those provided to you to simulate
// asynchronous operations that could take a while.

Future<String> fetchRole() => Future.delayed(_halfSecond, () => _role);
Future<int> fetchLoginAmount() => Future.delayed(_halfSecond, () => _logins);

// The following code is used to test and provide feedback on your solution.
// There is no need to read or modify it.

void main() async {
  print('Testing...');
  List<String> messages = [];
  const passed = 'PASSED';
  const testFailedMessage = 'Test failed for the function:';
  const typoMessage = 'Test failed! Check for typos in your return value';
  try {
    messages
      ..add(_makeReadable(
          testLabel: 'Part 1',
          testResult: await _asyncEquals(
            expected: 'User role: administrator',
            actual: await reportUserRole(),
            typoKeyword: _role,
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportUserRole?',
            'User role: Instance of \'Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role: Instance of \'_Future<String>\'':
                '$testFailedMessage reportUserRole. Did you use the await keyword?',
            'User role:':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: ':
                '$testFailedMessage reportUserRole. Did you return a user role?',
            'User role: tester':
                '$testFailedMessage reportUserRole. Did you invoke fetchRole to fetch the user\'s role?',
          }))
      ..add(_makeReadable(
          testLabel: 'Part 2',
          testResult: await _asyncEquals(
            expected: 'Total number of logins: 42',
            actual: await reportLogins(),
            typoKeyword: _logins.toString(),
          ),
          readableErrors: {
            typoMessage: typoMessage,
            'null':
                'Test failed! Did you forget to implement or return from reportLogins?',
            'Total number of logins: Instance of \'Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: Instance of \'_Future<int>\'':
                '$testFailedMessage reportLogins. Did you use the await keyword?',
            'Total number of logins: ':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins:':
                '$testFailedMessage reportLogins. Did you return the number of logins?',
            'Total number of logins: 57':
                '$testFailedMessage reportLogins. Did you invoke fetchLoginAmount to fetch the number of user logins?',
          }))
      ..removeWhere((m) => m.contains(passed))
      ..toList();

    if (messages.isEmpty) {
      print('Success. All tests passed!');
    } else {
      messages.forEach(print);
    }
  } on UnimplementedError {
    print(
        'Test failed! Did you forget to implement or return from reportUserRole?');
  } catch (e) {
    print('Tried to run solution, but received an exception: $e');
  }
}

const _role = 'administrator';
const _logins = 42;
const _halfSecond = Duration(milliseconds: 500);

// Test helpers.
String _makeReadable({
  required String testResult,
  required Map<String, String> readableErrors,
  required String testLabel,
}) {
  if (readableErrors.containsKey(testResult)) {
    var readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

// Assertions used in tests.
Future<String> _asyncEquals({
  required String expected,
  required dynamic actual,
  required String typoKeyword,
}) async {
  var strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return 'PASSED';
    } else if (strActual.contains(typoKeyword)) {
      return 'Test failed! Check for typos in your return value';
    } else {
      return strActual;
    }
  } catch (e) {
    return e.toString();
  }
}