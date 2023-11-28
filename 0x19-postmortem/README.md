POSTMORTEM
On December second 2022, at 1620 hrs East African Time (EAT) here in kenya, there was a national power outage (Kenya Power and Lighting Company a.k.a KPLC are never prepared during the rains) that crippled major server banks across the nation. One of the server banks affected was the one that hosted the Rogueminds.tech website. GET requests on the server led to 500 Internal Server error. The outage was caused by heavy rains that poured and affected a major power station that supplied the country with power. Good thing this time it wasn't an animal such as a snake like last time.

DEBUGGING PROCESS
The debugging process began at some few minutes after the outage was reported (1630 hours) and our DevOps team was hot on the case to redirect traffic and get the servers back online.The following procedures were then followed to try and redirect traffic to the remaining active servers we had online:

Checked running processes using ps aux. Two apache2 processes - root and www-data - were properly running.

Looked in the sites-available folder of the /etc/apache2/ directory. Determined that the web server was serving content located in /var/www/html/.

In one terminal, ran strace on the PID of the root Apache process. In another, curled the server. Expected great things... only to be disappointed strace gave no useful information.

Repeated step 3, except on the PID of the www-data process keeping expectations lower this time... but was rewarded! strace revealed an -1 ENOENT (No such file or directory) error occurring upon an attempt to access the file /var/www/html/wp-includes/class-wp-locale.phpp.

Looked through files in the /var/www/html/ directory one-by-one, using Vim pattern matching to try and locate the erroneous .phpp file extension. Located it in the wp-settings.php file. (Line 137, require_once( ABSPATH . WPINC . '/class-wp-locale.php' );).

Removed the trailing p from the line.

Tested another curl on the server. 200 A-ok!

Wrote a Puppet manifest to automate fixing of the error.

SUMMARY.

After vigorously trying to retrieve data that was housed in the main servers that were down, the DevOps team (me, myself, I and others) were able to redirect traffic to the remaining two server that luckily were not affected by the blackout as they are not hosted in the country for such reasons. The team was well prepared as this was not the first time this has happened as it turns out national power company are usually never prepared for such rains every year.

PREVENTION
However much cheaper it is to host our main servers in the country and our backups outside the country, we are beginning to realize that in the long term it would be more effective to pay more and prevent such blackouts from affecting our beloved site every time it rains. We could also prevent this from happening by having a better backup system so as not not loose any of our data during such an event in future. Always keep an eye on your servers to ensure they are running properly. Have extra back-up servers to prevent your program from completely going offline during an issue and choose the best load balancing algorithm for your programs.

