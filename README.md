# azure-resume-challenge-bicep
Doing the Cloud Resume Challenge again, this time with bicep.

I ran into a few problems, mainly because I misdefined secrets and had to go back and correct them. I also had an interesting issue on the backend yml deployment. It kept failing due to there not being a *.azurefunctions* file available. After a great deal of fiddling with the code, I discovered that the issue was acutally in my *functionapp.bicep* module, where I set the runtime to NET instead of python...