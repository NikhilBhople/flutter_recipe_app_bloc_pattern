# flutter Recipe App

A Flutter application which demonstrate the BLoC pattern,\
 API calling,\
 Separating business logic from widget,\
 Writing clean code,\
 Unit testing,\
 and Infinite page scrolling (pagination) 

## App Screenshot
<p>
  <img src="images/RecipeApp.png" width="320" height="620" title="Recipe Search app with BLoC pattern">
</p>


## App Architecture 
<p>
  <img src="images/AppArchitecture.png" width="300" height="350" title="BLoC pattern">
</p>

Repository is responsible to get the data either from API or local database\
BLoC stands for (Business logic component) which handle the business logic of app\
HomeScreen will render the UI to which user can interact

# Core Concepts BLoC

<p>
  <img src="images/Bloc.png" width="600" height="300" title="BLoC pattern">
</p>

## Events
Events are the input to a Bloc. They are commonly added in response to user interactions such as button presses or lifecycle events like page loads.

## States
States are the output of a Bloc and represent a part of your application's state. UI components can be notified of states and redraw portions of themselves based on the current state.

## Transitions
The change from one state to another is called a Transition. A Transition consists of the current state, the event, and the next state

## Streams
A stream is a sequence of asynchronous data.\
In order to use Bloc, it is important to have a solid understanding of Streams and how they work.\
If you're unfamiliar with Streams just think of a pipe with water flowing through it. The pipe is the Stream and the water is the asynchronous data.

<p>
  <img src="images/BlocStreams.png" width="800" height="250" title="Block steams flow">
</p>

## Sink: 
Using sink we can add the data to steam. In code Bloc.add(EventName)
## Source: 
By using sorce we can Consume the data
