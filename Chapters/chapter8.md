## Bonuses

Bonuses are extra functions that we gain during the game. We decide to implement 
a simple bonus system.  We attach a bonus to a brick and when this brick is 
destroyed the bonus it contained starts its effect, after a certain moment the 
bonus effect vanished if necessary.

Again there are several ways to introduce bonuses in the game, one would be to 
use morphs because they are objects having the notion of time passing via their 
step method. However the main point of a morph is that it is a graphical objects 
so we chose not to implement as a subclass of Morph. We let you as an exercise 
to convert our solution to use morph and for example change so that destroying a 
brick would produce a bonus falling down the screen and that its effect would be 
effective only when we would succeed to get the falling bonus.

@@ need a picture with a large batter@@

### Bonus

A bonus is an object that may have a certain *duration* once actived. Therefore 
define the class `Bonus` with two instance variables `duration` and `timeLeft`. 
As we do not plan to have graphical representation for the bonuses, subclass the 
class `Bonus` from the class `Object`.

A bonus has a given duration that is initialized is the method `initialize` (see 
method 8.1)

@@need a sequence diagram here @@

Once activated the effect of a bonus may last a certain period of time. We need 
a way to start it, notify it that the time is passing and terminate the effect. 
Therefore we define the method `start: aField`, the method `oneStep: aField`, and 
the method `end: aField`. We pass as argument the game in which the bonus is 
activated to have the possibility to change all the aspects of the game.

The method `start: aField` shown in method 8.2 initializes the `timeLeft` value.  
This value is then decreased by the method `oneStep: aField` that will be called 
a regular interval by the field (see method 8.3). When the timeLeft is zero it 
calls the method `end: aField` (see method 8.3) which has the responsibility to 
notify the field that the bonus is terminated.

### Two Bonuses

To specify bonuses now we just have to subclass the class `Bonus` and specialize 
the methods that control the life time of a bonus (`start:`, `end:`, or `oneStep:`). 
Now are ready to define the bonuses that shrink and enlarge the batter. Define 
one subclass of the class `Bonus` named `BatterShrinker`. The principle is the 
following: redefine the methods `start: aField` and `ctend:` so that the default 
behavior is still invoked and then define the bonus specific behavior.

For example for the `BatterShrinker` the method `start:` is defined as shown in 
method 8.12, the default behavior defined on the class `Bonus` is invoked and 
the batter is shrunk. When the bonus activity period is over, the method `end:` 
invoke the default behavior and then gives the batter its normal size.

We need then to define the methods `shrink`, `scaleBy:`, and `normalSize` on the 
class `BatterMorph` that we let you discover.

We let you as an exercise to implement the bonus that gives extra lifes. Note 
that this bonus does not use a duration so do not forget to change its 
initialization. It could use the following method defined on the class 
`BreakOutField`

Now we have defined bonuses but they are not managed by the field.

### Managing Active Bonuses


In our solution the field acts as a clock for the bonuses, it has the 
responsibility to ask every bonus to do one step in this behavior. Therefore the 
field should know the active bonuses. Add the instance variable `activeBonuses` to 
the class `BreakOutField`. Define the method `initializeActiveBonuses`
(see method 8.16) and modify the method `initialize` to invoke it.

Now we define the method `addActiveBonus: aBonus` (method 8.18). This method 
will be called when a brick containing a bonus will be destroyed. It adds the 
bonus to the list of the active bonuses and send the message `start:` to the 
bonus.

The method `step` of the `BreakOutField` class is invoked by the system 
regularly. This method askes all the bonuses to execute one step by sending them 
the message `oneStep:`

Finally the method `bonusTerminated: aBonus` that is invoked when a bonus 
terminated its activity period, just remove the bonus from the list of active 
bonuses (see method 8.20).

### Enhancing Brick With Bonus

Now a brick should have the possibility to have an hidden bonus. Add the 
instance variable `bonus` to the class `BrickMorph` and define the following 
methods

### Dispatching Bonuses

Now we are ready to distribute the bonuses in the bricks. We could have fixed 
the number of bonuses dispatched in the bricks in the `BreakOutField` but we can 
do better. We let the bonus decide their percentage of distribution among the 
brick. For that reason, we define on each bonus class a *class* method named 
`percentage` that returns the percentage of the bonus inside the bricks of a 
level. Note that the default percentage defined on the class `Bonus` is **20%**, 
subclasses only need to define the method `percentage` if they want a different 
percentage.

Now every time we install a new level, we just have to dispatch bonuses inside 
the destroyable bricks of the level as shown by the method method 8.27, method 
8.28, method 8.29, and method 8.30. Note that we change the definition of the 
method `installCurrentLevel` and create the method `destroyableBricks` because 
we need it in another place (see method 8.30).


The method `dispatchBonus` method 8.29 collect all the subclasses of the class 
`Bonus` and for each of them the bonuses are dispatched as shown by the method 
`dispatchBonus:`. The percentage of the bonus is converted into the number of 
bricks in the current level that should have a bonus of this kind. Then we pick 
a brick at random and associate it a bonus. We repeat this operation the right 
number of times. To help debugging this method we define the method 
`revealBonuses` that changes the color of the bricks having a bonus (see method 
8.31).

Now you should be able to play and have bonuses. This terminates the project on the breakOut.

### Lessons Learnt

minimize duplicated code, event for minimizing coupling, change in collaboration
