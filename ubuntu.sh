sudo apt update
sudo apt-get remove needrestart -y
sudo apt upgrade -y

#Install JDK 21
sudo apt install openjdk-21-jdk -y
sudo sed -i '3iexport JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64' /etc/profile
sudo sed -i '4iexport PATH=$JAVA_HOME/bin:$PATH' /etc/profile
source /etc/profile

#Install Maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xf apache-maven-3.9.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.9 /opt/maven
sudo sed -i '5iexport M2_HOME=/opt/maven' /etc/profile
sudo sed -i '6iexport MAVEN_HOME=/opt/maven' /etc/profile
sudo sed -i '7iexport PATH=${M2_HOME}/bin:${PATH}' /etc/profile
source /etc/profile

#Install git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y

#Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable --now jenkins

#Install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
