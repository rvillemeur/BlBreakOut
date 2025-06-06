## Level Description

In this chapter we introduce a way to define different levels. In the next 
chapter we will introduce then the possibility to finish a level and pass to the 
next one. This chapter introduce....

Up until now we position the bricks using different programs. This way of doing 
things does not go really far because we cannot be forced to program one by one 
all the levels. Adding a new level should require no coding at all. Instead we 
would like to have a way to represent the different kind of bricks and having a 
way to interpret this representations to populate the break out field with the 
correct bricks.

### Level Representations

We have to choose a representation for the levels so that after we can create 
various levels in a easy way and in a completely generic manner. We do not want 
to have to code one single line of code afterwards to generate a new levels. We 
chose to represent a level by a string as the one below

```txt
'SSSSSSSS
EEEEEEEE
SSSSSSSS
EEEEEEEE
SSSSSSSS
EEEEEEEE
SSSSSSSS
EEEEEEEE
XXXXXXXX
EEEEEEEE
SSSSSSSS
EEEEEEEE
XXXXXXXX
'
```

The idea is that each line in the string represents a line of bricks. Each 
element is a code that represents the kind of brick. The game should be able to 
read and to interpret such a string and create the corresponding bricks. One 
of the problem we have is how to store the levels descriptions so that we will 
not have to enter again and agin. We could have save them on file but we chose a 
simple approach that consist of defining each level descriptions as a method of 
the class BreakOutField. This way we can edit them and save them with the game. 
So method

Once you have defined the `level0` method, you can get the level representation 
by executing `BreakOutField level0`. The Figure 6.1 corresponds to the level 
description returns by `BreakOutField level0.` For that we interpreted the S as 
normal `BrickMorph`, `E` as empty slot, and `X` as `ResistantbrickMorph`.

### Template Generation

Define another level description in your own method on the class side. As you 
certainly notice this is boring to count exactly the number of bricks so to ease 
the generation of level description we would to define a method, called 

In fact the logic of such a method is quite simple, we have to have two loops , 
one for the lines and one for the row and to put at the end of each line a 
carriage return character (`Character cr`). The first simple problem we have to 
solve is that we do not know the number of rows and columns of a field. Right 
now to know the size of the complete area we have to create an instance of 
`BreakOutField` and send it the message `playFieldSize` (see method 5.2) as follow 
`|ctBreakOutField new playFieldSize`

However, we do not want to have to create an instance just for the sake of 
getting the default size of the field. So we propose to define such a method on 
the class `BreakOutField` itself as the class always exists (See method 5.3). 
This way we are able to get the size without having to create extra instance.

Then we change the method method 5.2 into method 5.4 to avoid the duplication of 
size information.  This way changing the size of the break out only requires to 
specify it at one single place.

Now to get the number of rows we have to execute `self playFieldSize x` 
independent of the fact that we are editing an instance or class method. But 
this is a bit clumsy. Indeed the reader of the code have to understand that 
`playFieldSize` returns a point. As we do not show that we used a point to 
encode the size of the field we define simply two methods `maximumColumnNumber` 
and `maximumRowNumber`. They will help us to write code that does not show the 
way we encoded the field size and communicate better its intent. The method 
`maximumRowNumber` does not return the complete size of brick line but only the 
one where we can have bricks

The method `generateEmptyTemplates` described by method 5.6 uses a stream. We do 
not want to go into the detail of stream but a stream is a kind of structure in 
which other objects can be put sequential and can later retrieve. Here we create 
a `ReadWriteStream`, i.e., a stream in which we can put and read from element. 
We only use a limited functionality of stream. First we create a stream using 
the `on:` that requires a container for the elements we will put in the stream. 
We can adding character so we create a string with a default size. The size does 
not really matter because the stream will make the string grows if necessary. 
Then we use two loops: `self columnNumber timesRepeat: [aStream nextPut: $E]`. 
create one line in the level description, after which we put a carriage return 
using the expression `Character space. nextPut: anElement` puts the element in 
the stream. We repeat the first loops to create all the lines. Then we return 
the filled string by asking the stream its contents using the message 
`contents`.

### About Conveying Intention


Oftentimes we are creating methods such as `numberOfBrickLines` instead of using 
`playFieldSize y -12` and you may wonder because the two expressions are strictly 
equivalent. This is true however a big part of programming is not only t about 
designing the correct algorithm but also to write code that other persons or 
yourself in the future can read. Using the right terms and providing extra 
methods is a key point in writing applications. Note also that in general you 
will spend most of the time reading the code of somebody else to understand it 
and modify it. Therefore conveying the intention of the code is really important 
and using the correct terms or hiding certain information is an key activity.


### Interpreting the Level Description.

Now we are ready to implement a method that interprets the level description and 
create the bricks into the field. Let us call this method `installLevel: 
aLevelDescription`. Such a method is invoked for example as follow `aBreakOut 
installLevel: aBreakOutField class level0`. Now we have to know the character at 
a given position in the level description and create the corresponding brick.  
However, we cannot access the character directly using a row and a column. The 
only way to access a character inside a string is to specify the character 
position by reference to the beginning of the string. The message `at: aNumber` 
sent to string returns the character at the aNumber position. In the Figure ??, 
the character `r` which is at the column 3 and row 2, the 12th element of the 
string: 9 characters per line plus 3 for the column.  

We have to take care that in one line of the level description there is not 
eight characters but nine because we should not forget the carriage return 
character at the end. That is the 1 character of the second line is the tenth 
element and not the nineth. Let us implement the method 
`brickDesccriptionAtColumn:row:` that returns the results presented in the script 
??

Before looking at our solution, try to implement it because it is a good 
exercise. To help you you can use a Transcript and an expression that print the 
method argument and the result you would obtain such as for example `Transcript 
show: aColumn printString, , aRow printString; show: ’ ’ ; show: (aColumn + 
(aRow* self class maximumColumnNumber)) ; cr`

In the method BreakOutField»brickLine: (see method ??) and that we show again 
hereafter, we first create an instance then position it.

Now the class of the created brick depends on the brick description character 
that we get from the level description. Therefore we have to find a way to get 
the class associated with a given character. For this purpose we define the 
method `brickClassFromDescription: aCharacter` as shown in method 5.9 that given a 
character returns the associated class. Note that such a method does not handle 
the case of the character E because we do not have class associated with empty 
brick. This method works but is not the best one. We will show later how a much 
better solution is possible. We let you think for now on the problems of such a 
solution.

The script 5.4 presents how we the method brickClassFromDescription: is used to create
bricks.

`(BreakOutField new brickClassFromDescription: $S) newStandAlone openInWorld`

Now we are ready to implement the method `installLevel: aDescription`. The method 
5.10 shows a possible implementation. The final point to resolve is to place the 
bricks at the right place in the field. Here we have to pay attention that the 
position of the brick at the column 1 and row 1 is `0@0` relatively to the field. 
The method `placeBrick: aBrick atBrickCoordinate: aPoint` (method 5.11) ensures 
first that the created brick has the default brick size, then it positions the 
brick by transforming the logical coordinates given by the level description to 
concrete coordinate in terms of brick size. Note that the position of a brick is 
global and not by reference to its container (which a design mistake of the 
Morphic system), therefore we should not forget to add the position of the field


Now we have to invoke the method `installLevel:` when the field is initialized. In 
a following chapter we will introduce the fact that we change levels when we 
finish them. Therefore we change the method `BreakOutField»initializeToStandAlone` 
to invoke the method `installLevel:` and `initializeBricks` to remove the line of 
brick creation as shown hereafter.

### About Design

This section goes a bit far in comparing different choices we have to represent 
level description management and then can be skipped in a first reading.

We took the choice to define the behavior related to level generation in the 
class level of the class `BreakOutField`. That way we could simply send messages 
to the class BreakOutField itself as for example `BreakOutField level0`. 
However, doing that we have mixed two different responsibilities: playing the 
game and managing level descriptions. What is implied in the choice we made is 
that we only have one set of level descriptions. Indeed when we send the message 
`BreakOutField gatherAllDefinedLevels` we do not not distinguish between 
different sets we get all the defined levels.

In our case this is not a real problem, because we defined only a couple of 
methods but you should be aware that having too much methods at the class level 
not related to strict class responsibilities is a sign of bad design. One of the 
most striking example of bad design in the squeak 3.2 environment is the class 
`@@Wiki@@`. Because it represents...and its instance method....

Alternatively in our case we could have created a separated class named 
`LevelDescriptionManager` whose role would have been to manage (support definition 
and store) of description levels.

The choice we made is valid while we do not have to have multiple instances 
managing different sets of level description. For example, if we would like to 
have multiple objects responsible for storing different sets of level 
descriptions then our choice would start to be clumsy because we would have 
started to need instance variables at the class side representing something else 
than class properties and it would be much better to have one new class with 
clearly identified state and responsibilities.

A basic implementation of the same behavior we had implemented on the class side 
of the class `BreakOutField` is to define the class `LevelDescriptionManager`.

Try to introduce such a class in your implementation to identify the change you 
would have to make.  Introducing different level description sets would require 
to add some extra state and a different way of storing the level descriptions.

The method `brickDescriptionAtColumn: aColumn row: aRow` his not using any of 
the instance variables of a breakOutField instance and nearly no functionality. 
This is often the sign that the method is not defined on the correct class. It 
might mean that a class is missing, the class `LevelDescription` that would 
represent a level description and provide such a kind of behavior. Here we 
decided not to define it because having a string and using a method to store it 
was the simple thing to do. However, in other applications defining methods that 
do not access nor instance variables nor methods is a sign that a class is 
missing or that the method is defined on the wrong class. This does not mean 
that you have to create a class or change the method class immediately but that 
you should pay attention at other signs that would indicate it.

**About Changes.** What is important when designing a system is that we should 
always be ready to change it when new functionality are required. Oftentimes 
people try to forsee all the possibilities upfront. Therefore they often design 
systems that are bloated with unnecessary code and cases. Note that having tests 
help to check whether the changes introduced break the functionality already 
working is an important help.  In this book we did not introduce testing as we 
focus more on teaching the concept of object-oriented than good software 
engineering practices

### Undestroyable Bricks

Now we want to introduce another kind of brick: bricks that cannot be destroyed. 
Now you should be able to add such a functionality without looking at our 
solution. An undestroyable brick is a brick that only produces a sound when it 
is bumped by the ball. We do not present in detail our solution.


Now if we want to be able to use this new kind of brick we have to change the 
method `BreakOutField»brickClassFromDescription: aCharacter` so the system knows 
that we use the character `$U` to represent `UndestroyableBrickMorph` in level 
description.

### Automatic Brick Registration

As we saw in the previous section adding a new brick requires to change the 
method `brickClassFromDescription: aCharacter` and this is the sign that our 
design is not that good. In fact there are several problems: first we have to 
recompile the method `brickClassFromDescription:` each time we add a new kind of 
bricks, second the association between a character and a class is not clearly 
explictly.  This is the fact logic of the method `brickClassFromDescription` 
while it would be better that the brick itself specify such an association. In 
fact we would like to show you how a simple registration mechanism can solve 
this problem. The idea is that each kind of brick knows the character that 
represents it in a level description. Then each kind of brick tells this 
information to the `BreakOutField` which uses it to know which kind of brick to 
create. This way new kinds of bricks do not have to modify the class 
BreakOutField. This example is also the opportunity to show you how 
dictionaries, a collection that associates a value to a key, work.

#### Associating a Character to Brick Classes

The first step is to let the responsibility to associate a character to the 
brick classes

The first expression of the script 5.5 shows how we can access the description 
character declared by a class. The second expression returns all the subclasses 
of the class `BrickMorph`.  The third expression use the method `withAllSubclasses` 
which returns a collection of all the subclasses of the receiver including 
itself. The last expression shows how we can get all the subclasses of the class 
`BrickMorph` including itself and collect their declared description character.


#### Setting the Registration

The idea is that we use a dictionary, a collection that associates a value to a 
key. Each kind of brick then register its class associated with the character 
that represents it. Then by querying the dictionary we automatically know which 
class to instantiate. The script 5.6 shows a typical use of dictionary: we 
create one, put some values associated with key, here we associated names of 
animal with their weight and we query it

**Example of Dictionnary use**
```st
| d |
d := Dictionary new.
"Now we associate animal names and their weight"
d at: #monkey put: 50.
d at: #elephant put: 1000.
d at: #ant put: 0.001.
d at: #dog put: 50.
"Now we can get the weight of an animal by asking the value associated
with the animal name"
d at: #monkey    -Print It-> 50
d at:#elephant   -Print It-> 1000
```

We first add a new instance variable `brickDescriptions` to the class 
`BreakOutField`. It will contain the mapping between the description characters 
and the classes.

We then modify the `initializeBricks` method, to initialize the variable 
`brickDescriptions` with an empty dictionary, then to fill the dictionary with 
the description characters and the classes. We get all the subclasses of 
BrickMorph including itself, for each of them we add as association in the 
dictionary the description character and the class is it associated with (see 
method 5.20). If you want to check what has been put inside the dictionary, 
create a breakOut game using the usual expression `BreakOutField newStandAlone 
openInWorld`, then using the red halo, access the inspect morph menu item and 
browse the instance variables of the inspected object as shown in the Figure 
5.3.


Now we can change the method `brickClassFromDescription:` to query the 
dictionary `brickDescriptions` to get the class associated with the description 
character as shown in the method 5.21.

### What you learned
