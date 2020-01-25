# Slanguage

Slanguage is a Duolingo-like app in which the user can learn slang from around the world. Teaching both common slang words and funny phrases, this app can help the user bond with locals and learn how to say common phrases other language apps do not teach. After selecting a language, the user is given prompts of either translating phrases word-by-word or tapping and pairing slang words from given words. There is also audio of the phrases to help the user learn pronunciation and a leaderboard which shows the top 20 users so that the user can compete with their friends. The currently implemented languages are Argentinian Spanish, Australian English, Brazilian Portuguese, and Italian.


![Screenshot 1](https://i.imgur.com/iSKhA7E.png) ![Screenshot 2](https://i.imgur.com/9TKjqlS.png) ![Screenshot 3](https://i.imgur.com/GV4E2wW.png)


Timeline:
- October 14th: Started the project with a PageController, which I ended up not using. Was not sure what I wanted to make yet.
- October 17th: Thought of the idea for Slanguage, and built a prototype which had the basics of a Duolingo-like app: given an array in Spanish, the user was given buttons of the tranaslation that they would have to click in the right order.
- October 18th: Got it to work fluidly with a check button, which when clicked checks the user's translation and prints "Incorrect!" or "Correct!" before showing the new prompt.
- October 19th: Made it so it randomly chooses between giving you an English -> Spanish translation or Spanish -> English. Worked on making the buttons rearrange correctly when another button was pressed so that there would never be empty space between 2 buttons. Added more phrases and added random words that would appear to make the translation harder for the user.
- October 20th: Added audio I recorded of the Spanish phrases to help the user with pronunciation. Added a Tab View Controller to switch between the language learning screen and the leaderboard screen (which was empty to this point). Added a "Next" button that the user can click to start a new prompt rather than just instantly having a new one as soon as they check the right answer.
- October 21st: Animated the movement of the buttons so they quickly move rather instantly pop in its destination. Added a "Hear" button that the user can click to hear the current phrase.
- October 22nd: Deleted the Next button and made it so the Check button instead would double as both depending on the context. Added a "Correct!" view that tells the user they are correct rather than just relying on printing to the console. Added a progress bar for the current lesson and added an "Incorrect!" view that serves the same purpose as the "Correct!" view but tells the user the translation was wrong. Cleaned up the code to be more efficient and made some design changes.
- October 23rd: Added Australian English and a screen where the user can choose between the two available languages. Started work on the "Tap Pair" minigame where the user has to choose which words mean what translated. Added a back button to the Translate screen that takes the user back to the Language Select screen. Made it so after the user inputs a correct translation, they can no longer click on the words until they go on to the next prompt.
- October 24th: Finished the tap pairs mini game and moved the "Correct!" and "Incorrect!" code into its own functions, correct() and incorrect().
- October 25th: Made it so the buttons are always centered, as before it was too left-heavy or right-heavy depending on whether the row had long words or short words. In order to make this possible, I changed the way the tapping on words works during translations: now the buttons have a fixed position and return to it when the button is clicked at the top, rather than every button constantly readjusting its position based on the position of other buttons. Added frames to the buttons at the bottom so when the button is at the top, there is a gray frame that shows where it would return (its original position). Added an Argentinian and an Australian flag to the launch screen to replace the buttons that said "ARG" and "AUS." Also added an Italian and a Brazilian flag, both of which are currently not clickable. Also added the current flag to the learning screen at the top, next to where it says the name of the app. Fixed bug where the current audio clip would be deleted after an incorrect response, which would lead to a crash later on. Added image to the hear button (button clicked to relisten to current phrase) to replace text. Added 2 lines which the translate buttons sit on after being pressed for a better design look. Changed textToTranslate to appear from the left, next to the hear button, rather than center. Still must do something with the text when it says "Tap the Pairs" (either make it centered or just erase it and replace the "TRANSLATE" on top). The pairs to tap now appear much higher in the screen. Changed the color and shape of buttons.
- October 27th: Added a leaderboard screen where it puts you up against a currently pre-made list of other "users." Added a score system where you gain 100 points every time you complete a prompt, and is saved using UserDefaults.standard. Made many design changes, such as changing the title's font and the color of progress bar, check button, button frames, and more.
- October 29th: Added a login, signup, and startup screens. Added functionality for signing up and logging in using Firebase.
- November 4th: Fixed Firebase issues by uninstalling and reinstalling pods.
- November 11th: Fixed up some transitions, got rid of the "Swipe to Dismiss" functionality.
- November 30th: Made some design changes on multiple screens and added a placeholder logo for the title page.
- December 1st: Implemented a database using Firebase Firestore. Now when signing up the user's username, score, and current language is set in the database. The signup screen now also has a field for username so that the user is not just known by their email. The username must be at least 4 letters long.
- December 2nd: Got the score and current language system implemented in the Firestore database so that now it is updated correctly. The app mostly uses UserDefaults as to not have too many calls to the database, but updates the database to the UserDefaults whenever the back button is pressed in the Translate screen and updates the UserDefaults to the database when the app is started. Got the leaderboard connected to the database so now it actually reads through the top users and displays their names and scores. Fixed bug where language selected was always Argentinian Spanish and bug where Leaderboard was not working correctly when scrolled through.
- December 3rd: Added Brazilian Portuguese as a language the user can learn, with phrases and words. Brazilian Portuguese audio not implemented yet, currently Argentinian Spanish audio is being used as a placeholder.
Changed the leaderboard to have the 20 top users rather than just 5, as now there are over 20 users signed up. Fixed bug where logged out user would show as blue in leaderboard rather than the current user.
Usernames can no longer include spaces.
Fixed bug where currLang would be saved as currlang in the database.
- December 4th: Added Italian as a language the user can learn. Structured the code so it could be read more clearly and to make it easier to add new languages to the program easily.
- December 5th: Added icons in the tab bar for Learn and Leaderboard screens. Changed the design of the Login and Signup pages.
- December 6th: Added some alerts for the user to be able to know what went wrong, replacing some instances where it would only print the error to console.




- I got the flags from: https://www.flaticon.com/packs/international-flags-3
- I got the font used for the title from: https://www.urbanfonts.com/fonts/Bombing.font


I learned how to use:
- UITableViews from: https://www.youtube.com/watch?v=dObOj2MMYzA and https://stackoverflow.com/questions/34877476/uitableview-inside-a-viewcontroller-with-custom-cell-without-storyboard
- CGAffineTransform from https://stackoverflow.com/questions/31259993/change-height-of-uiprogressview-in-swift/31260320
- Audio from: https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
