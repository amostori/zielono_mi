1. Tworzenie ikony okrągłej
    Na stronie https://makeappicon.com/result/ można wykreować ikony normalne i okrągłe.
2. Dependencies

 dart run build_runner build
 flutter packages pub run flutter_launcher_icons:main
 flutter build web

 void addTodo(Todo todo) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
 state = [...state, todo];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
 }

 void removeTodo(String todoId) {
   // Again, our state is immutable. So we're making a new list instead of
   // changing the existing list.
   state = [
     for (final todo in state)
       if (todo.id != todoId) todo,
   ];
 }
 void toggle(String todoId) {
   state = [
     for (final todo in state)
     // we're marking only the matching todo as completed
       if (todo.id == todoId)
       // Once more, since our state is immutable, we need to make a copy
       // of the todo. We're using our `copyWith` method implemented before
       // to help with that.
         todo.copyWith(completed: !todo.completed)
       else
       // other todos are not modified
         todo,
   ];
 }
