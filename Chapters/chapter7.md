## Managing Multiple Levels

### Collecting Levels

In the chapter ?? we show how we represent a level as a level description. We 
define a class method level0 that was returning a level description that was 
used to create effectively the bricks of a level. We use now the same technique 
to define all the level of a game. We create several class methods that 
represent all the levels of the game. The method 7.1 shows how another level is 
defined and returned by the method `level1`. To be able to automatically identify 
all the levels defined, we follow the conventions that a level is always 
associated with a method starting with the word `level`.

Once the level description are defined and associated with methods we can get 
them. The idea is that we will collect all the class methods that start with the 
word ’level’, then we will invoke these and keep the returned level 
descriptions. The scripts 7.1 and 7.3 shows several operations that help us to 
gather all the defined levels. The method `selectors` returns all the methods 
defined by a class

Now that we have a way to know all the methods returning a level description we 
have to execute them to effectively get the returned level descriptions. 
Smalltalk offers a way to invoke method explicitly using the method `perform: 
aSymbol` where aSymbol is the method selector of the method been invoked.


Now we can combine the two functionality to write the method 
`gatherAllDefinedLevels` as shown in method 7.2. We use the method `collect:` 
that execute the block specified as argument on all the elements of the receiver 
and returns a collection containing all the results.

### Managing Levels

Now we are ready to have a breakout with multiple levels. The idea is that we 
use a collection holding all the level descriptions, and we use a number to 
represent the current level. When we change level we increment the level number 
and install the level description corresponding. For this purpose, we need to 
add two new instance variables to the class `BreakOutField` to represent the 
current level and the levels available.

Now we are ready to define how the levels are used in the game and how we pass 
from one level to the next one. We have to collect all the defined levels, 
initialize the game, and install the first level by creating all the bricks as 
specified by a level description. The first thing to do is to collect all the 
defined levels and initialize the instance variables `levels` to refer to the 
collection of level description. We change the method `initializeToStandAlone` 
(see method 7.3) to invoke a new method called `installLevels` (see method ??  
which will have this responsibility. Note again that the method 
`initializeToStandAlone` is composed conceptually by method having the same 
level of abstractions. This helps the reading and understanding of its 
functionality. Imagine if all the code of each method would be just included 
direclty in the method `initializeToStandAlone`. This would lead to a really 
complex method that would be difficult to change and extend

Now we have to modify the method `initializeGame` to specify that the game starts 
at the first level and (method 7.5) install the current level.

Installing a level is just invoking the method `installLevel: aLevelDescription` 
that we defined in the chapter ?? with the level description corresponding with 
the current level number.

The method `isLastLevel` just uses the fact that the length of the level 
description collection represent the total number of levels. Therefore we are at 
the last level if the length is equal to the level number.

#### Next Level

From now you can start playing and the system should display the first level you 
define on the class side.  The second step is to make sure that when the last 
brick is destroyed, the game passes to the next level. For that we have to 
change the method `moveBall` (see method 7.8) so that it checks when a brick is 
touched if it was the last one.

As every times a brick is destroyed it is removed from the bricks instance 
variable collection, we can consider that a level is terminated when this 
instance variable holds an empty collection (see method 7.9).

Installing the next level is then pausing the game, increasing the level number, 
installing the level, and resetting the ball and batter position. In method 7.10 
we check that if the level was the last one we restart at the beginning.

Now when you finish a level, you pass to the next one and when you are at the end of the last level you restart at the beginning.

### The Case of Undestroyable Bricks

In fact we forgot the case of the bricks that we cannot destroy. Right now our 
solution does not work because as soon as a level contains one of such a brick, 
the method `isLevelTerminated` described above always returns false. In this 
section we propose to solve that problem. There are several ways to solve this 
problem. Before reading our approach think about one or two ways of solving it 
and evaluate the pros and cons in terms of complexity, i.e., how much 
information you should keep synchronized, or in terms of speed.

Our idea is that at the installation of a level we count all the bricks that 
have to be destroyed and then every time a brick is destroyed we decrement the 
number we originally calculated. Therefore add a new instance variable called 
`destroyableBrickNumber` to the class `BreakOutField`. The number of destroyable 
bricks should always be initialized when a new level is installed, therefore we 
obvious place to compute it is the method `installCurrentLevel` (see method 
7.11)

We then have to change the implementation of the method `isLevelTerminated` to 
check whether all the bricks that should be destroyed are effectively.

The implementation of the method `installCurrentLevel` (see method 7.11) is not 
really good.  Indeed we hardcode the name of a class directly in the method. 
This means that we as a client of a brick takes decision while the brick itself 
should be responsible of such decision. Here the decision taken by the client, 
the class `BreakOutField` is simple but we can easily imagine cases where the 
logic of the decision would imply checking different conditions. Therefore the 
tests could depend on several classes.  In addition referring explicitly to 
class names is a bad practice because if we change the name of the class we have 
to change all the references too.

The solution is to let the brick tell us whether they are destroyable or not 
(see method 7.13). To do thatwe define the method `isDestroyable` which on the 
class `BrickMorph` returns true. This means that all the subclasses of BrickMorph 
will be destroyable except if they redefine this method. On the class 
`UndestroyableBrickMorph` the method is redefined to return the value `false` 
indicating that the bricks of this class and its subclasses are not destroyable.

Now the solution we propose in method 7.13 is not really good because we create 
first a collection with all the bricks that should be destroyed but we do not do 
anything with it. So instead of collecting objects counting them is enough. 
Indeed collecting objects can be costly. The solution is to just count the 
bricks.  The method 7.16 shows one way to do it

Smalltalk collections offers a better way to do the same using the 
`inject:into:` method. However, this method lead to code that may be difficult 
to read, therefore if you do not feel confortable with it do not use it. The 
script 7.4 shows some examples of use of `inject:into:`. The idea is that the 
first argument is the starting value of the accumulator named `sum` or `prod` 
and that is the first argument of the block passed as second argument. The 
second argument of the block (the second argument) is the element of the 
collection.

```st
#($a $b $a $b $a $b) inject: 0 into: [:sum :each | sum + (each = $a ifTrue: [1] ifFalse: [0])].
-Print It-> 3
#(1 2 3 4 5 6 7) inject: 0 into: [:sum :each | sum + each ]
-Print It-> 28
#(1 2 3 4 5 6 7) inject: 1 into: [:prod :each | prod * each ]
-Print It-> 5040
```

Try and you will discover that we have still two problems. First we forgot to 
change the number of bricks left to destroy.

### Lessons Learnt

You may wonder why we did not take into account the problem before. We did this 
on purpose to show you how a good method decomposition helps to change a system. 
An application that cannot change is a dead or useless application. Therefore 
you should always think that you system can change. However you should not try 
too much to see in which directions it will change. Having a clean code with 
short methods having clear responsibility and no duplication is the minimal way 
of been prepared to change. Another way is to write tests for each important 
responsibility you implement. We do not present this aspect in this book except 
in the chapter for lack of time and space.

level or levelNumber, destroyableBricks or destroyableBrickNumbe
