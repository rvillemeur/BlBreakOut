## Score, Lifes, and New Game

Now we would like to add some This will be the pretext to present some important 
issues related to lowering the coupling between classes and the use of accessor 
methods. @@ More @@


### Scores

We would like to add a score to the game. The idea is that eveyrtimes a brick is 
destroyed or bumped, the score is increased. For this purpose, add the instance 
variable `score` to the class `BreakOutField`.  Do not forget to initialize this new 
variable to zero. Then define the methods `increaseScoreBy: aNumber` (method 6.1).

Now change the method `actionWhenBumpedBy: aBall` to increase the score number 
of the breakout field.

We let you do the same for the resistant brick if you want.

### Game suspending, Restarting and Reseting

We would like to introduce the fact that the game can be paused, restarted and 
reset


The code of the method initializeToStandAlone starts to be messy. Indeed we have 
different levels of details, sometimes really low level such as `color:` or at 
the opposite `initializeBricks` which represents several low-level operations. 
We will refactor it to the same level of abstraction once we have finish the 
pause and restart.

Now we decide that we can pause and restart the game by pressing space bar. We 
change the method `keyDown:` event that handles the keyboard event to implement 
this functionality (see method 6.7).

Now that pausing the game works, we take the time to clean the method 
`BreakOutField»initializeToStandAlone`. You can wonder why this is interesting 
to change a method that is working. The idea is that if the method starts to be 
unreadable and its logic complex then we will have problem to use it, extend it 
to take into account new requirements, the complete system will start to be more 
fragile and adding new functionality will start to be quite difficult. Therefore 
the fact that a method works and its quality in terms of readibility and logic 
are the two faces of the same coin. Having badly written methods working does 
not prove that you will be able to go fast and change easily your system

A not really satisfactory version of the method `initializeBatterMorph` is shown 
in method 6.10

However, when we analyse the class we see that the method `batter:` is only 
called by this method, so this is an opportunity to avoid to have small methods 
implementing separate but related functionality.  Therefore we merge them, i.e., 
remove batter: and change the logic of `initializeBatterMorph` as shown in 
method 6.11.

We do the same for the method `ball:`: we remove it and include its logic into 
the method `initializeBallMorph`.

### Lifes

Now we are ready to add multiple lifes to the game. First we add a new instance 
variable named `lifes` to the class `BreakOutField` and modify the method 
`initializeGame`

Now we can easily write the method `lostABall` as shown in method 6.16

Now when we lose a ball, we check whether we can continue to play. If we can we 
decrement the number of lifes, reset the batter and the ball and pause the game 
waiting for the user

### A Board

Now we would like to see our score and the lifes left. So we create a board game 
for the breakout. However we do not explain the following code because it would 
lead us in too much details.

We create then duplication between the method `initializeToStandAlone` and 
`newGame`, so refactor the method initializeToStandAlone to call `newGame`.

### Updating Board Information

Now the final problem we have to solve is that the score displayed is not 
updated when the score instance variable of theBreakOutField changes.  

In fact we could change the BreakOutField class to have a reference to its board 
and changes directly the value of the score display. However this way of doing 
think is bad because we would be hardcoding in the code of the BreakOutField 
information about other objects that are not related to it. For example, we 
could build several different boards and we do not want to change the 
breakOutField class every times.  The BreakOutField class works well completely 
in a autonomous manner from the board.  

In fact what we need is a way for the board to be aware that some elements of 
the breakoutField change. In a similar fashion, when we register to a online 
publishing house, the house does not have to change, it just notifies us when 
something new is available, then we go to read it if we want. Squeak offers the 
following solution. The BreakOutField class should trigger events telling which 
parts of his internal state changes, then the board or any other objects 
interested register some interests into the events that it needs and performs 
certain actions if necessary. This way we decouple the breakOutField class from 
the BreakOut class. The BreakOutField does not have to know or to take care that 
the board exists. We could have multiple boards presenting different information 
at the same time without having to change the breakOutField class.

The final small problem we have is that the field is created, the event 
`lifesChanged` is triggered but the board does not really exist yet so the life 
number is not correctly displayed. Therefore once its creation ends, we 
explicitly tell it to update the life number as show below.

### About Encapsulation and Accessors

To be sure that the number of lifes represented in the break out board are 
always a correct representation of the number of lifes currently in the game, we 
have to find all the places in the class `BreakOutField` that change the value 
of the instance variable `lifes`. Missing only one of those would lead to 
inconsistent states. The methods `lostABall` (see method 6.31) and 
`initializeGame` (see method 6.30) show this problem. You could think that as it 
is working this is ok. The problem is that if we add bonuses that give life as 
we will do it in the future, we will have again to keep in mind that we have to 
trigger an event, else the graphical interface could be in an inconsistent 
state. Again having a duplicated logic is the sign that there is potentially a 
problem.

The solution is to have only one point where the `lifes` instance variable value 
is changed and to trigger the event from this place. For that purpose we define 
the method `lifes: anInteger` as shown in method 6.33


Then we change the method `initializeGame` and `lostABall` accordingly (see 
method 6.34 and method 6.35).


As we presented in the chapter ?? presenting objects, an object is responsible 
of the data it contains. It can specifies various behavior in the way it wants.  
It hides its internal representation from clients so that he can change it 
without impacting them. Clients should only rely on the interface provided by 
the object.  This property is called data encapsulation. Now in Smalltalk all 
the methods are public, this means that clients can invoke any methods the class 
implements. There is no way that we can forbid it. Therefore, when we define a 
method that simply provides access or change the value of an instance variables, 
usually called *accessor* methods, clients can completely breaks the 
encapsulation or internal logic of an object. The solution in Smalltalk is to 
rely on conventions to know whether a client should or not used methods. We 
define the method `lifes: anInteger` in the private protocol or method 
categories to indicate that clients should not use this method.

In fact using accessors or not was a big debate, most of the Smalltalk 
programmers use accessors. In this book, we took the decision not to use them, 
because we want to promote the idea of encapsulation and we wanted to avoid 
methods doing nearly nothing. Kent Beck in his excellent book Best Smalltalk 
Practices [] provides really useful discussions about the use of accessors. Now 
when using accessors two points have to be taken into account: first this is not 
because accessors are methods that they do not break encapsulation, so you 
should take care when you are invoking accessor methods of a class and 
especially multiple of them in sequence. Expressions such as `anObject address 
street number` are a real problem because if one of the class `Person`, 
`Address`, `Street` changes the client code breaks. In chapter ?? we present the 
Law of Demeter that helps designing decoupled classes. The idea is to avoid 
sending messages to result of messages. Second if you use accessors you should 
use them consistently for all the instance variables of a class and never mixed 
them with direct access use. To that regard the method method 6.35 may shoke 
purists because it mixes direct instance variable access and accessors. However 
here we follow our non use of accessor and only call the method `lifes:` that is 
more than an accessor.

### Lessons Learnt

Duplicated code or logic is always the symptom of a potential problems
- Accessors do not
- decoupling classes: events...
