AKSpellingCorrector
===================

Simple spelling checker, takes a word with max 10 letters length, and returns the most popular correct word of this wrong one.

This is an 'Objective C' spelling corrector based on Peter Norvig's article, and you can find it on this URL: http://norvig.com/spell-correct.html

Please feel free to browse the code, and add your custom changes as you wish.

# Install
1. Download the project.
2. Drag `AKSpellingCorrector` folder into your XCode project, and add all files to your target.


# Usage

```objective-c
#import "AKSpellingCorrector.h"

NSString* correctedString = [[AKSpellingCorrector sharedInstance]correctWord:@"correktion"];

BOOL stringExist = [[AKSpellingCorrector sharedInstance]checkWord:@"correction"];

```


# Make your custom dictionary

The algorithm depending on extracting a dictionary from huge text file, and it measures the frequency of each word in that text file.
So the accurecy of this library is deneding on your input file, and those are the steps to regenerate your custom dictionary based on your custom text file:

1. Download the project.
2. Open the `AKSpellingCorrector-Trainer` project -it's a Mac project-.
3. There is a file called `big.txt`, replace it's content with your custom text -don't forget to save it-.
4. Run the project, and after it start to run you should see this line in the log:
``` Trainer started ```
5. And after a while your will get this line:
``` Trainer finished ```
6. Open your finder, and browse to your `Documents` folder, you will see a new file called `Dictionary.sqlite`.
7. Copy `Dictionary.sqlite` to `AKSpellingCorrector/Data/`, and this should replace the old dictionary.

###### Warning: Don't run the trainer twice because it will duplicate the dictionary data!


# Contact

Please feel free to mail me @(ahmedahk52@gmail.com)