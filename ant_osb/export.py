from java.io import FileInputStream
from java.io import FileOutputStream
from java.util import ArrayList
from java.util import Collections

from com.bea.wli.sb.util import EnvValueTypes
from com.bea.wli.config.env import EnvValueQuery;
from com.bea.wli.config import Ref
from com.bea.wli.config.customization import Customization
from com.bea.wli.config.customization import FindAndReplaceCustomization

import sys

#=======================================================================================
# Utility function to load properties from a config file
#=======================================================================================
def exportAll():
    try:

        ALSBConfigurationMBean = findService("ALSBConfiguration", "com.bea.wli.sb.management.configuration.ALSBConfigurationMBean")
        print "ALSBConfiguration MBean found"

        print project
        if project == "None" :
            ref = Ref.DOMAIN
            collection = Collections.singleton(ref)
            if passphrase == None :
                print "Export the config"
                theBytes = ALSBConfigurationMBean.export(collection, true, None)
            else :
                print "Export and encrypt the config"
                theBytes = ALSBConfigurationMBean.export(collection, true, passphrase)
        else :
            ref = Ref.makeProjectRef(project);
            print "Export the project", project
            collection = Collections.singleton(ref)
            theBytes = ALSBConfigurationMBean.exportProjects(collection, passphrase)

        aFile = File(exportJar)
        out = FileOutputStream(aFile)
        out.write(theBytes)
        out.close()
        print "ALSB Configuration file: "+ exportJar + " has been exported"

        if customFile != "None":
            print collection
            query = EnvValueQuery(None, Collections.singleton(EnvValueTypes.WORK_MANAGER), collection, false, None, false)
            customEnv = FindAndReplaceCustomization('Set the right Work Manager', query, 'Production System Work Manager')
            print 'EnvValueCustomization created'
            customList = ArrayList()
            customList.add(customEnv)
            print customList
            aFile = File(customFile)
            out = FileOutputStream(aFile)
            Customization.toXML(customList, out)
            out.close()

        print "ALSB Dummy Customization file: "+ customFile + " has been created"
    except:
        raise

# EXPORT script init
try:
    exportAll()

except:
    print "Unexpected error: ", sys.exc_info()[0]
    dumpStack()
    raise