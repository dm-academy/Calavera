# trying to create a slave programmatically.
# works, but can't figure out how to create a new credential the same way. 

import jenkins.model.*
import hudson.model.*
import hudson.slaves.*
import  hudson.plugins.sshslaves.*;
import com.cloudbees.plugins.credentials.CredentialsScope;



pk = new BasicSSHUserPrivateKey(CredentialsScope.GLOBAL, "c012b0a2-ba8c-4bbb-8b86-2c1bdc4ae486", "root", \
     new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource("/root/.ssh/rsa_id"), \
                                  "", "")
// <privateKeySource class="com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$FileOnMasterPrivateKeySource">
// from https://github.com/yahoojapan/docker-continuous-integration-workflow/blob/master/jenkins/credentials.xml

Jenkins.instance.addNode(new DumbSlave("brazos","test slave description",\
                                       "/home/jenkins","1",Node.Mode.NORMAL,"test-slave-label",\
                                       new SSHLauncher("brazos", 22, "abcdefgh", "vagrant", "/root/.ssh/rsa_id", "test", "test2"),\
                                       new RetentionStrategy.Always(),new LinkedList()))


#SSHLauncher (host, port. ?, JVM Options, Java Path, Prefix Start, suffix start)

// pk = new BasicSSHUserPrivateKey(CredentialsScope scope, String UUID, string username, PrivateKeySource privateKeySource, \
                                  String passphrase, \
                                  String description)
                                  
//the code below at least does not throw an error. It doesn't deliver a new credential either. 

import jenkins.model.*
import hudson.model.*
import hudson.slaves.*
import hudson.plugins.sshslaves.*;
import com.cloudbees.plugins.credentials.CredentialsScope;
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*;

pk = new BasicSSHUserPrivateKey(CredentialsScope.GLOBAL, "c012b0a2-ba8c-4bbb-8b86-2c1bdc4ae486", "root", \
     new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource("/root/.ssh/rsa_id"), "", "")  