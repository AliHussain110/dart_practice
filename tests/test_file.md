Problem 1: Advanced Data Processing with Error Handling (Classes, Async, Error Handling)
You are building a system that processes user profile data from a mock API. The data is inconsistent and may contain errors. Your task is to fetch the data, validate it, process it, and handle any potential issues gracefully.
Task:
1. Define a UserProfile class with the following properties:
    ◦ id (int)
    ◦ name (String)
    ◦ email (String)
    ◦ age (int)
    ◦ Add a const constructor for this class.
    ◦ Implement a copyWith method.
2. Create a custom exception class called InvalidProfileDataException that takes a message string.
3. Implement an asynchronous function processUserData(List<Map<String, dynamic>> rawData). This function will:
    ◦ Take a list of raw user data (maps).
    ◦ Iterate through the list and attempt to create a UserProfile object from each map using a factory constructor on the UserProfile class called UserProfile.fromJson.
    ◦ The factory constructor should validate the data:
        ▪ If id, name, email, or age is missing or null, it should throw your InvalidProfileDataException.
        ▪ If age is less than 18, it should also throw the exception.
    ◦ The processUserData function must use a try-catch block for each user to handle the InvalidProfileDataException. Invalid user profiles should be ignored (and a message printed to the console), not stop the entire process.
    ◦ Return a Future<List<UserProfile>> containing only the valid profiles.
Provided Mock Data (for your main function to call the processor):
void main() async {
  final List<Map<String, dynamic>> mockApiData = [
    {'id': 1, 'name': 'Alice', 'email': 'alice@example.com', 'age': 30},
    {'id': 2, 'name': 'Bob'}, // Missing email and age
    {'id': 3, 'name': 'Charlie', 'email': 'charlie@example.com', 'age': 17}, // Too young
    {'id': 4, 'name': 'David', 'email': 'david@example.com', 'age': 45},
    {'id': null, 'name': 'Eve', 'email': 'eve@example.com', 'age': 25}, // Missing id
  ];

  List<UserProfile> validProfiles = await processUserData(mockApiData);
  print('Processing complete. Valid profiles found: ${validProfiles.length}');
  // Expected output should indicate 2 valid profiles (Alice and David).
}
--------------------------------------------------------------------------------
Problem 2: Concurrent Stream-Based Data Aggregation (Streams & Isolates)
You are tasked with creating a real-time analytics dashboard. You receive two separate streams of data: user login events and transaction events. You need to process these events concurrently, aggregate the results, and provide a final summary. To ensure the UI remains responsive, the heavy lifting must be done in an isolate.
Task:
1. Create a function _aggregator(SendPort sendPort) that will run in an isolate. This function should:
    ◦ Accept a SendPort to communicate back to the main isolate.
    ◦ Set up two streams using Stream.periodic:
        ▪ loginStream: Emits a new "login" event every 300ms.
        ▪ transactionStream: Emits a random integer between 10 and 100 (simulating transaction value) every 500ms.
    ◦ Use StreamZip or a similar method to combine these streams.
    ◦ Listen to the combined stream for 2 seconds. For each event, accumulate the total number of logins and the sum of all transaction values.
    ◦ After 2 seconds, send a Map<String, int> back to the main isolate containing the final {'total_logins': count, 'total_revenue': sum}.
2. Implement the main function runAnalytics(). This function will:
    ◦ Create a ReceivePort to get data from the isolate.
    ◦ Use Isolate.spawn to start the _aggregator function.
    ◦ Wait for the result from the isolate.
    ◦ Return the final aggregated map.
Hint: You will need to manage the lifecycle of the streams and the isolate carefully. A Timer or Future.delayed inside the isolate will be needed to stop listening and send the result.
--------------------------------------------------------------------------------
Problem 3: Generic Caching System with Extensions (Generics, Mixins, Extensions)
You need to build a versatile, in-memory caching system. The system should be type-safe, allow for different caching strategies, and have a convenient API.
Task:
1. Create a generic abstract class Cache<K, V> with the following methods:
    ◦ void set(K key, V value);
    ◦ V? get(K key);
    ◦ void clear();
2. Create a mixin called TimestampedCache. This mixin should be usable on any class that implements Cache. It will:
    ◦ Store the DateTime of the last cache write operation.
    ◦ Provide a getter Duration? get timeSinceLastUpdate that returns the time elapsed since the last write.
3. Implement a concrete class InMemoryCache<K, V> that:
    ◦ implements Cache<K, V>.
    ◦ with TimestampedCache.
    ◦ Uses a private Map<K, V> for storage.
    ◦ Implements all methods from the Cache interface and correctly updates the timestamp when set is called.
4. Create an extension on InMemoryCache<String, int> called IntCacheUtils. This extension should add one method:
    ◦ int get sumOfValues => values.fold(0, (sum, val) => sum + val); where values is a getter that exposes the map's values.
Usage Example (for your main function):
void main() {
  var userScoreCache = InMemoryCache<String, int>();
  userScoreCache.set('player1', 100);
  userScoreCache.set('player2', 250);

  print('Player 2 score: ${userScoreCache.get('player2')}'); // Expected: 250
  print('Total score: ${userScoreCache.sumOfValues}'); // Expected: 350

  // Test the mixin
  Future.delayed(Duration(seconds: 1), () {
    print('Time since last update: ${userScoreCache.timeSinceLastUpdate}');
    // Expected: ~1 second
  });
}