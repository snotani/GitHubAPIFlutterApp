# GitHub Linguist API Flutter App

A new Flutter application for Code Language and Lines Detector GitHub.

This application is made to show you the language (and it's size in bytes) and the lines of code used
in your GitHub repository. I came up with this idea because usually in our Software Engineering group projects
at University we get asked to update the supervisors on how many lines of code of we have till date and what 
languages/frameworks we have used. Although there is other ways to find these out, this app just tells you to put
your username and repository name in and find this out at the moment! I used the GitHub Linguist API to get the
data for the languages and for the estimate of the lines of code I got the size of the project from the API and did
some calculations (divide by 40 because this is the average number of bytes per line in programming) to get these results.

It is designed to be run on an Android platform and the total dart code is of 5113 bytes.

Any suggestions on improvement are welcome! Contact the email at the end of the page.

## License

MIT License

Copyright (c) 2019 Siddharth Notani - s.notani@outlook.com
