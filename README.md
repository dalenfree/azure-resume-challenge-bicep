# azure-resume-challenge-bicep
Doing the Cloud Resume Challenge again, this time with bicep.

I ran into a few problems, mainly because I misdefined secrets and had to go back and correct them. I also had an interesting issue on the backend yml deployment. It kept failing due to there not being a *.azurefunctions* file available. I suspect it has to do with the way I built the bicep for the fucntion app, which was pretty much a template from Microsoft.