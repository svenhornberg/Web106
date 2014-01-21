import os,boto, boto.rds,time,datetime, boto.beanstalk
from boto.s3.connection import S3Connection
from boto.s3.key import Key
import boto.beanstalk.layer1 as wlayer
from boto.exception import BotoServerError


class Deploy:
    awsAccessKey = ""
    awsSecretKey = ""
    bucketName = "web106eb"
    fileName = "web106.war"
    applicationName = "web106"
    environmentName = "web106env"
    label = "web106prod"
    dbName = "ebdb"
    dbUser = "web106db"
    dbUserPassword = "web106db"
    region = "eu-west-1"
    dbEndpoint = None
    bucketKey = None
    bucketUrl = None
    applicationUrl = None
    solutionStackName = "64bit Amazon Linux running Tomcat 7"
    templateName = "t7web106"

    option_settings=[]
    bsContainer = "aws:elasticbeanstalk:application:environment"
    javaContainer = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    generalContainer = 'aws:autoscaling:asg'

    def __init__(self):
        date = datetime.datetime.now()
        print('starting deployment at '+str(date.hour)+":"+str(date.minute))

        self.createAwsCredentialsFile()           
        self.createWarFile()
        self.deleteAwsCredentialsFile()  
        self.uploadWarFile()
        self.createDbRds()

        self.fillOptionSettings()

        self.beanstalk()
       
        self.deployApp()
    
    def checkoutProjectFromGit(self):
        print "checkout"
    
       
    def createWarFile(self):
        print 'Try to create war file...'
        os.system("./grailsw prod war " + str(self.fileName))
        
    def uploadWarFile(self):
        print "start uploading war file"
        connS3 = S3Connection(self.awsAccessKey, self.awsSecretKey) 
        nonExistend = connS3.lookup(self.bucketName)
        bucket = None
        
        if nonExistend is None:
            print "start creating bucket"
            bucket = connS3.create_bucket(self.bucketName)
            print "done creating bucket"
        else:
            bucket = connS3.get_bucket(self.bucketName)
            print "bucket already exists"
               
        k = Key(bucket)
        k.key = self.fileName
        print "uploading..."
        k.set_contents_from_filename(self.fileName)
        
        self.bucketKey = k.key
        self.bucketUrl = k.generate_url(expires_in=0, query_auth=False)
        
        print "done uploading war file"
        
    def createDbRds(self):
        connRds = boto.rds.connect_to_region(
            self.region,
            aws_access_key_id=self.awsAccessKey, 
            aws_secret_access_key=self.awsSecretKey
        )
        db = None
            
        try:
            db = connRds.create_dbinstance(self.dbName,5,"db.t1.micro",self.dbUser,self.dbUserPassword) 
        
        except:
            print "DBInstance already exists"        
            
        instances = connRds.get_all_dbinstances(self.dbName)
        db = instances[0]

        while db.endpoint == None:
            time.sleep(5)
            instances = connRds.get_all_dbinstances(self.dbName)
            db = instances[0]

            date = datetime.datetime.now()
            print "waiting for endpoint "+str(date.hour)+":"+str(date.minute)
         
        self.dbEndpoint = db.endpoint[0]
            
        
    def fillOptionSettings(self):
         
        #tg1 = generalContainer, 'MaxSize', '4' 
        #tg2 = generalContainer, 'InstanceType','t1.micro'
       
        tb1 = self.bsContainer, 'AWS_SECRET_KEY', self.awsSecretKey
        tb2 = self.bsContainer, 'AWS_ACCESS_KEY_ID' , self.awsAccessKey

        query = 'jdbc:mysql://'+str(self.dbEndpoint)+":3306/"+str(self.dbName)+"?user="+str(self.dbUser)+"&password="+str(self.dbUserPassword)        
        
        tb3 = self.bsContainer, 'JDBC_CONNECTION_STRING', query
        
        tb4 = self.bsContainer, 'PARAM1' , self.dbUser
        tb5 = self.bsContainer, 'PARAM2', self.dbUserPassword
         
        tj1 = self.javaContainer, 'Xms', '256m'
        tj2 = self.javaContainer, 'Xmx', '256m'
        tj3 = self.javaContainer, 'XX:MAXPermSize', '512m'
        
        for x in [tb1,tb2,tb3,tb4,tb5,tj1, tj2,tj3]:
            self.option_settings.append(x)

    def beanstalk(self):
        
        #connect
        connEB = boto.beanstalk.connect_to_region(self.region,
            aws_access_key_id=self.awsAccessKey, 
            aws_secret_access_key=self.awsSecretKey
        )    
        
        try:
            
            #1
            wlayer.Layer1.create_application(connEB, self.applicationName)
    
            #2
            wlayer.Layer1.create_application_version(
                connEB, application_name=self.applicationName,version_label=self.label, 
                s3_bucket=self.bucketName, s3_key=self.bucketKey, 
                auto_create_application=True
            )
            #3
            wlayer.Layer1.create_configuration_template(connEB,
                 application_name=self.applicationName, template_name=self.templateName,
                 solution_stack_name=self.solutionStackName)
            
            #4
            wlayer.Layer1.create_environment(connEB,
            application_name=self.applicationName, environment_name=self.environmentName,
            template_name=self.templateName, cname_prefix=self.applicationName, option_settings=self.option_settings
            )   
            
           
        
        except:
            print 'delete envrionment and application, if you want to build from scratch'
        
        
        
        #5
        statusFlag = "Red"
        while statusFlag != "Green":
            status = wlayer.Layer1.describe_environments(connEB)
            statusFlag = status['DescribeEnvironmentsResponse']['DescribeEnvironmentsResult']['Environments'][0]['Health']
            
            
            time.sleep(5)
            date = datetime.datetime.now()
            print "waiting for green status "+str(date.hour)+":"+str(date.minute)
        
        

    def createAwsCredentialsFile(self):
        fileName = "AwsCredentials.properties"
        if os.path.isfile(fileName):
            print "existing file updated"
            os.remove(fileName)            
        else:
            print "file with credentials created"
        
        file = open(fileName, 'w+')
        file.write("# Fill in your AWS Access Key ID and Secret Access Key"+os.linesep)
        file.write("# http://aws.amazon.com/security-credentials"+os.linesep)
        file.write("accessKey = "+self.awsAccessKey+os.linesep)
        file.write("secretKey = "+self.awsSecretKey)
        
        file.close()
        
    def deleteAwsCredentialsFile(self):
        fileName = "AwsCredentials.properties"
        os.remove(fileName)
        print "removed AwsCredentials.properties File" 
        
        
    def deployApp(self):
        #connect
        connEB = boto.beanstalk.connect_to_region(self.region,
            aws_access_key_id=self.awsAccessKey, 
            aws_secret_access_key=self.awsSecretKey
        ) 
        status = wlayer.Layer1.describe_application_versions(connEB, self.applicationName)   
        label = status['DescribeApplicationVersionsResponse']['DescribeApplicationVersionsResult']['ApplicationVersions'][0]['VersionLabel']
        
        wlayer.Layer1.update_environment(connEB, environment_name=self.environmentName, version_label=label,
                                        template_name=self.templateName,option_settings=self.option_settings)
                                        
        statusFlag = "Red"
        while statusFlag != "Green":
            status = wlayer.Layer1.describe_environments(connEB)
            statusFlag = status['DescribeEnvironmentsResponse']['DescribeEnvironmentsResult']['Environments'][0]['Health']
            
            
            time.sleep(5)
            date = datetime.datetime.now()
            print "waiting for green status "+str(date.hour)+":"+str(date.minute)
                                        
        print "Version " + label + " of " + self.applicationName + " is now deployed." 
        #url
        status = wlayer.Layer1.describe_environments(connEB)
        print status['DescribeEnvironmentsResponse']['DescribeEnvironmentsResult']['Environments'][0]['CNAME']            

if __name__ == "__main__":
    d = Deploy()
    













