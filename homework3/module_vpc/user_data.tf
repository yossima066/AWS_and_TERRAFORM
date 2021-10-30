locals {
  my-nginx = <<USERDATA
  #!/bin/bash
  sudo apt update -y
  sudo apt install nginx -y
  sudo rm /usr/share/nginx/html/index.html
  echo'<html><head><title>Blue Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Welcom to Grandpas Whiskey</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
  service nginx restart

  USERDATA
}
