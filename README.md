# 4 Images 1 Word Solver

Puzzle Solved | results.txt
: -------------------------: |: --------------------- ---: | --------------------
! [] (./ screenshots / sreen_one.png) | ! [] (./ screenshots / screen_two.png) | ! [] (./ screenshots / screen_three.png)

#### Case study
My goal was to have a script/application that would help me solve the puzzle "4 Pics 1 Word".
To do this, we have to automate the process of logical thinking that would solve this puzzle.
The cognitive process is:
- Write down the words that would describe the images.
- Get the permutations that can be made from the letters from which we can choose.
- Match the words from our glossary (words that correspond to the description of the images) and the results of our permutations with a length of 4 letters.
- Finally we end with a number of results that contain the answer.

#### Steps to be taken
For each cognitive procedure we would write a method that would fulfill the goal.
So we would have a method: analysis_images, permutation and match_results.
- The analysis_images method returns a list of words describing the images.
- The permutation method would get the permutation of the letters from which we can choose, it must also only return the permutation with a length of 4 letters.
- Finally the match_results method corresponds to the results of analysis_images and permutation. If there is no match, we can compare the permutation results with a list of English words, for example a "dictionary.txt".

#### Analyze the problem
First we need an API that can analyze the images, for example [Google's cloud vision](https://cloud.google.com/vision) api or the [Clarifai's image and video recognition](https://clarifai.com/) api . The success of our application largely depends on how well our api can recognize the images.
In fact, we try to determine possible results by trying hundreds or sometimes thousands of possible possibilities. This technique is known as a [dictionary attack](https://en.wikipedia.org/wiki/Dictionary_attack).

In addition, we make a combination of a series of letters and filter the results that do not correspond to the length of 4. If we want to make it modular by adding more letters to our array, this will result in possible thousands of permutations. All those permutations that we have to match with our glossary or dictionary. This can be time-consuming. In order to optimally use our resources, we must choose a language that is fast at runtime e.g. a C language or Go.

To speed up the actual "attack", we first try to match our permutations with the glossary generated from our image recognition api. If that does not work, we can check the permutations with a dictionary that contains a list of 4 letter words.

#### Writing a prototype (POC)
Before we build the final application, we first write a prototype that would prove that our idea that we want to build is feasible. The prototype does not contain any interaction with an api or anything like that. We also do not have to think about making it modular or do some error handling. These things come later. I chose Ruby because it is easy to write readable code that is capable of doing almost anything with just a few lines of code.

#### Result
All of the test (10 out of 10) were positive, resulting in an output of a maximum of 250 words, of which 1 was correct. If we found a match from our glossary instead of comparing the permutations with a dictionary, the results were much lower (about 3 max). Even if the results contain a maximum of 250 words, it was not difficult to find the answer, because the probability of most results was very low. For example: rime and roke would have a low probabilty, while rich would have a high probabilty.

#### Room for improvement
As I have said before, in order to limit the outcome, we must filter out the words with a lower probability. This is only the case if we do not find a match in our glossary.

### Sources
- [Permitation of 4 letters] (https://www.quora.com/How-many-permutations-of-4-letters-can-be-made-out-of-the-letters-of-the-word- exam)
- [Find all possible permutations with Ruby and recursion] (https://stackoverflow.com/questions/25224321/find-all-the-possible-permutations-using-ruby-and-recursion)
- [Dictionary attack] (https://en.wikipedia.org/wiki/Dictionary_attack)