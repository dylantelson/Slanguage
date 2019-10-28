Slanguage is a Duolingo-like app in which the user can learn slang from around the world. After selecting a language, the user is given prompts of eitehr translating phrases word-by-word or tapping and pairing slang words from given words. There is also audio of the phrases to help the user learn pronunciation and a leaderboard for the user to compete with their friends. Currently the only languages implemented are Argentinian Spanish and Australian English, but soon I will add Brazilian Portuguese and Italian (their flags are already in the app). The leaderboard is also currently not connected to a database, but rather shows a pre-existing placeholder list where the user can climb up (currently, 100 points are awarded per prompt completed). 

I got the flags from: https://www.flaticon.com/packs/international-flags-3
I got the font used for the title from: https://www.urbanfonts.com/fonts/Bombing.font

I learned how to use:
UITableViews from: https://www.youtube.com/watch?v=dObOj2MMYzA and https://stackoverflow.com/questions/34877476/uitableview-inside-a-viewcontroller-with-custom-cell-without-storyboard
CGAffineTransform from https://stackoverflow.com/questions/31259993/change-height-of-uiprogressview-in-swift/31260320
Audio from: https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift

Most of the work came from making the core game work, with all objects interacting together correctly. It was also difficult to get the game working well on many different devices. Through programming this game I learned how to code videogames through XCode, which is surprisingly close to Unity (which I have a lot of experience with).

Timeline:
September 23rd: Started the game, with the core mechanics of a runner: a player character (typical of a runner game, rather than a ball) that jumps when the phone is tapped and they are on the floor. Platforms would come from the right forever, making an infinite runner. The player loses if he hits the bottom or left side of the screen.
September 24th: Replaced the player character with a ball that is propelled by swipes, added ceiling platforms, and added the touching and coloring of platforms.
September 28th: Added a variety of saw obstacles. Got the game working well on every phone from iPhone SE to iPhone Xs Max.
September 29th: Added a saw shooter obstacle.
September 30th: Added a score and high score system. Added a save system for the high score.
October 2nd: Added a main menu scene that transitions to the main game when a button is pressed.
October 6th: Rehauled the main menu, changed the design of the game and some text, and added a pause function for debugging.
October 9th: Changed size of high score and current score text, commented out the pause function as it was interfering with gameplay.
October 13th: Changed rate at which obstacles appear and disappear to make gameplay harder.