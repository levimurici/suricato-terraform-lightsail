resource "aws_lightsail_instance_public_ports" "suricato-iot" {
  instance_name = aws_lightsail_instance.suricato-iot.id

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 1880
    to_port   = 1880
  }

  port_info {
    protocol  = "tcp"
    from_port = 1883
    to_port   = 1883
  }
}

resource "aws_lightsail_static_ip" "suricato-iot" {
  name = "SuricatoStaticIp-2"
}

resource "aws_lightsail_static_ip_attachment" "suricato-iot" {
  static_ip_name = aws_lightsail_static_ip.suricato-iot.id
  instance_name  = aws_lightsail_instance.suricato-iot.id
}