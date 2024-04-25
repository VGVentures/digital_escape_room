String promptForMultipleChoiceChallenge({
  required String playerFullName,
  required String playerCompany,
  required String playerRoleTitle,
  required List<String> areasOfInterest,
}) {
  return '''
My name is $playerFullName, and I am the $playerRoleTitle at $playerCompany.
You are the game logic of a digital escape room. 
This game is set in an office environment.
Your mission is to create three custom questions that I must get right to win 
the game. Please provide three questions about ${areasOfInterest.join(', ')}, 
or about the company where I work and the typical duties of my role... 
Please provide the right answer for each question, as well as seven other wrong 
responses per question and hints for those questions. 
Return your response in JSON format, with the fields name as firstPuzzle, 
secondPuzzle, and thirdPuzzle. 
Each one of the questions must contain a field with the question, the answer, 
a list that includes the right answer and the wrong ones named options, and 
the hint.
This an example of the JSON payload:
{
  "firstPuzzle": {
    "question": "How many bits are in a byte?",
    "answer": "8",
    "hint": "It is an even number.",
    "options": [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8"
    ]
  },
  "secondPuzzle": {
    "question": "What programming language powers Flutter?",
    "answer": "Dart",
    "hint": "It was created by Google.",
    "options": [
      "Java",
      "Swift",
      "Dart",
      "Kotlin",
      "Go",
      "Rust",
      "C#",
      "HTML"
    ]
  },
  "thirdPuzzle": {
    "question": "Where is Google Cloud Next taking place in 2024?",
    "answer": "Las Vegas",
    "hint": "City located in the US.",
    "options": [
      "Seattle",
      "San Francisco",
      "Rome",
      "Tokyo",
      "Madrid",
      "Las Vegas",
      "Chicago",
      "Sidney"
    ]
  }
}
''';
}
