from java.io import FileInputStream
from java.io import FileOutputStream
from java.util import ArrayList
from java.util import Collections
from java.util import HashSet

from com.bea.wli.sb.util import EnvValueTypes
from com.bea.wli.sb.util import Refs
from com.bea.wli.config.env import EnvValueQuery
from com.bea.wli.config.env import QualifiedEnvValue
from com.bea.wli.config import Ref
from com.bea.wli.config.customization import Customization
from com.bea.wli.config.customization import FindAndReplaceCustomization
from com.bea.wli.config.customization import EnvValueCustomization

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
# see com.bea.wli.sb.util.EnvValueTypes in sb-kernel-api.jar for the values

#EnvValueQuery evquery =
#     new EnvValueQuery(
#         null,        // search across all resource types
#         Collections.singleton(EnvValueTypes.URI_ENV_VALUE_TYPE), // search only the URIs
#         null,        // search across all projects and folders.
#         true,        // only search across resources that are
#                      // actually modified/imported in this session
#         "localhost", // the string we want to replace
#         false        // not a complete match of URI. any URI
#                      // that has "localhost" as substring will match
#         );

            refTypes = HashSet()
            refTypes.add(EnvValueTypes.SERVICE_URI_TABLE)
            refTypes.add(EnvValueTypes.SERVICE_URI)
            query = EnvValueQuery(Collections.singleton(Refs.BUSINESS_SERVICE_TYPE), refTypes, collection, false, "search string", false)
#           query = EnvValueQuery(None, Collections.singleton(EnvValueTypes.SERVICE_URI_TABLE), collection, false, "search string", false)
            customEnv = FindAndReplaceCustomization('new endpoint url', query, 'replace string')

#            object = QualifiedEnvValue(Refs.makeBusinessSvcRef(ref,'file'), Refs.BUSINESS_SERVICE_TYPE, "XSDvalidation/file", "aaa")
#            objects = ArrayList()
#            objects.add(object)
#            customEnv2 = EnvValueCustomization('Set the right endpoints', objects)

            print 'EnvValueCustomization created'
            customList = ArrayList()
            customList.add(customEnv)
#            customList.add(customEnv2)

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