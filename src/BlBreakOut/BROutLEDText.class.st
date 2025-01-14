"
you can load a directory with fonts (e.g. .ttf and .otf files) this way: 
`AeFontManager globalInstance scanDirectory: '../../fonts' asFileReference`

There is also 
`AeFontManager globalInstance scanDefaultDirectories`
which takes a second to find font files in the typical font directories in current platform (OS)

For example, say you have a font called ""Minecraft"" in a relative directory. 
This font has only ""Medium"" type (this is important, too):

```smalltalk 
AeFontManager globalInstance scanDirectory: '../../fonts' asFileReference.

BlTextElement new
    text: ('Hola, Bonjour, Hello!' asRopedText
            fontName: 'Minecraft' ""<--- family name"";
            medium; ""<--- weight""
            fontSize: 50;
            yourself);
    openInNewSpace.
```
"
Class {
	#name : 'BROutLEDText',
	#superclass : 'BlElement',
	#category : 'BlBreakOut-Helper',
	#package : 'BlBreakOut',
	#tag : 'Helper'
}
