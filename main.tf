

# Generate a Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "my-ec2-key"
  public_key = file("C:/Users/Vijesh/.ssh/id_ed25519.pub")  # Use your actual public key path
}

# Create a Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP access"

  # Allow SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Update with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "MyEC2Instance"
  }
}

# Create an EBS Volume
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = aws_instance.my_ec2.availability_zone
  size             = 10  # Size in GB

  tags = {
    Name = "MyEBSVolume"
  }
}

# Attach the EBS Volume to the EC2 Instance
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.my_ec2.id
}
