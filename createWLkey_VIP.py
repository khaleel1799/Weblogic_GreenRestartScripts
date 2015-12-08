import sys
import os.path
import thread
import time
# weblogic.socket mudule will be loaded to overwrite default socket module,
# after log into weblogic server.
import socket as pysocket

from java.util import Date
# Running from shell
# java weblogic.WLST filePath.py
ucf='./.prodAdmin_ConfigFile.sec'
ukf='./.prodAdmin_userKeyFile.sec'
urlFile='./.url.properties'  

if ( not os.path.isfile(ucf) ) or ( not os.path.isfile(ukf) ) or ( not os.path.isfile(urlFile) ) :
    admurl   = raw_input('Enter weblogic Admin Console t3s URL(like t3s://127.0.0.1:7001): ')
    username = raw_input('Enter User Name for weblogic Console: ')
    password = raw_input('Enter Password for weblogic Console: ')   
    try:
        f=open(urlFile,'wr+')
        f.write(admurl)
        f.flush()
        f.close            
        connect(username,password,admurl,timeout='10000')
        storeUserConfig(ucf,ukf)
        print '# Successfully stored encrypted user credential and url to files.'            
    except WLSTException, e:
        print '# Unable to Creates a user configuration file and an associated key file. Exit...'
        print e
        sys.exit()
    except IOError, e:
        print "# IOError\n", e
        sys.exit()
else:
    f=open(urlFile)
    admurl=f.readline().rstrip()
    f.close()
    connect(userConfigFile='./.prodAdmin_ConfigFile.sec',userKeyFile='./.prodAdmin_userKeyFile.sec', url=admurl)


f=open('VIP_MS.txt','wr+')
serverlist=cmo.getServers()
for svr in serverlist:
    # Always get SSL port since regular port should be disable according to iSEC.
    svrurl=pysocket.gethostbyname(svr.getListenAddress()) + ':' + str(svr.getSSL().getListenPort())
    if svr.getMachine() != None:
        mchname = svr.getMachine().getName()
    else:
        mchname = "None"
    f.write (svrurl + " " + svr.getName() + " " + mchname + "\n")

f.flush()
f.close

disconnect()

