resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
   vpc_security_group_ids = ["sg-09a92b159eb276c66"]
   key_name               = "KeyPairNV" 
   iam_instance_profile =   "EC2Role"
   user_data = <<-EOF
      #!/bin/bash     
      sudo amazon-linux-extras install ansible2 -y
      sudo yum install git -y
      sudo yum install maven -y      
      git -C ./home/ec2-user clone https://github.com/sidhakale/Doc1.git          
      cd /home/ec2-user/Doc1 && ansible-playbook main.yml -f 10
      cd /home/ec2-user/Doc1 && wget -O Java-Ansible.war https://sidha.jfrog.io/artifactory/Maven1/MyMavanWebapp/Java-Ansible/0.0.1-SNAPSHOT/Java-Ansible-0.0.1-SNAPSHOT.war
      cd /home/ec2-user/Doc1 && ansible-playbook deploy.yml -f 10
      EOF
   }
