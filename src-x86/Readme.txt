________________________________________________________________________

Funambol 8.7.0                      July 12, 2010
________________________________________________________________________


Welcome to Funambol, your SyncML based mobile application platform.

The Funambol team is committed to making Funambol easy to install and use on
all major platforms. Please see the Quick Start Guide for more
information on how to run a demo to see the product in action.

We appreciate your suggestions and feedbacks. Please send your comments
to funambol-users@lists.sourceforge.net.


________________________________________________________________________

Funambol 8.7.0: what is included?
________________________________________________________________________

Funambol 8.7.0 includes:

 - Funambol Data Synchronization Server 8.7.0 - a Java SyncML 
server, that you can use with any SyncML client (e. g. to synchronize the 
address book on your phone through a pre-installed SyncML client)

 - Funambol CTP Server 8.7.0 - a CTP Server to support CTP notification

 - Funambol Administration Tool 8.7.0 - a standalone visual 
interface to administer the Funambol Data Synchronization Server

 - Funambol Java Demo Client 8.7.0 - a stand-alone visual
interface to test the synchronization of PIM data (contacts and calendar) 
with the Funambol Data Synchronization Server

 - Funambol Inbox Listener 8.7.0 -  a component to perfom push email
 
 - Funambol Pim Listener 8.7.0 -  a component to perfom push pim information

 - Web Demo Client - a demo web interface to visualize PIM data.

In order for the bundle to work, we also packaged Hypersonic (an open
source database, used to store internal data), a Java Runtime
Environment and a web server (Tomcat).


________________________________________________________________________

Funambol 8.7.0 Distribution Directory
________________________________________________________________________

After installing Funambol 8.7.0, you'll find a new Funambol 
directory under which all the software is installed (the physical 
position of the Funambol main directory is selected during setup). Let's
call such directory BUNDLED_HOME.

Under BUNDLED_HOME you find the following subdirectories and files:

BUNDLED_HOME 
  + admin          -> The graphical admin interface for Funambol 
                      Data Synchronization Server
  + bin            -> Starting/Stopping script files
  + config         -> Configuration files
  + ctp-server     -> The CTP Server
  + ds-server      -> The SyncML server
  + inbox-listener -> The InboxListener
  + logs           -> A logs directory
  + pim-listener   -> The PIMListener
  + plug-ins
       + java-demo -> A sample SyncML PIM graphical tool
  + tools          -> A tools directory, including Hypersonic, JRE and Tomcat
  + Readme.txt     -> This file

________________________________________________________________________

Funambol 8.7.0: installation
________________________________________________________________________

For Windows:
1. Download funambol-8.7.0.exe from www.funambol.com and 
run it. It will install the software.
2. Follow the instructions during the installation. The server will be
started automatically and you will see the Test Drive Guide.

For Unix/Linux:
1. Download funambol-8.7.0.bin from www.funambol.com on 
   your system.
2. Execute the downloaded file in a shell with, 
   'sh funambol-8.7.0.bin'. 
   This will ask you first for agreement with the license, secondly
   where to install the software by providing the <prefix> and then
   unpackage the software in <prefix>/Funambol. This will be your
   BUNDLED_HOME.
   The installation procedure also prints out the used server name
   which is a URL that you MUST use in the mobile device also.
3. Change directory to the BUNDLED_HOME, 'cd <BUNDLED_HOME>', and
   run the funambol script, 'sh bin/funambol start'.
4. Open the Test Drive Guide document at 
   http://funambol.com/docs/v71/funambol-test-drive-guide-v7.1.pdf. 
5. To stop the server change directory to the BUNDLED_HOME,
   'cd <BUNDLED_HOME>', and run the funambol script,
   'sh bin/funambol stop'.
