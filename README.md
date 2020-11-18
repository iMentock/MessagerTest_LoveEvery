# MessagerTest_LoveEvery
Virgil Martinez

## Objective
To demonstrate Swift and iOS experience. Completing objectives given by design document 'Mobile Homework 1.pdf'

## Requirements
1. Post messages to the API using the URL: https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages
2. Get all messages from the API using the URL: https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages
3. Get messages based on the submitter’s user name from the API using the URL: https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages/{user}

## Background 
Was given one week with the project. I finished the objectives a bit early so added some UI/UX elements. Had a lot of fun as well!

## Design
Using MVVM architecture created a series of Views, a View Model, and Models that accomplish given requirements. The ViewModel file and separation of services allows for 
unit-testing of API calls with the knowledge that the views will be updated according to the view model. 

The table view is appropriate to display the list of similar messages and the detail view give a clear look at the information given in each of 
the messages as well.

The user messages search is accomplished in the search bar present on the main messages view controller. When the user presses the go button the call is 
carried out and the table is updated with the given values or an error is presented. 

At any time the user can and may pull down on the table view to clear the search parameters and do a getAllCall. 

## Concerns/improvements/known issues
* The text view on the create message view controller does empty if the user wishes to edit after dismissing the keyboard. 
* The fetch on scroll down and every time the messages view controller comes in can be costly at scale. (FIX) Could locally cache
* The fetch by the user could also be (FIX) fixed by caching locally and then filtering by the user. Would have to make sure you have the latest data. 

## Testing plan
Adhering to MVVM will assure the view models may be unit tested and at scale, this would help with test-driven development. 
