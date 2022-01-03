output "suricato_services_web_ip" {
    value = aws_lightsail_static_ip.suricato-iot.ip_address
}

output "suricato_services_id" {
  value =  aws_lightsail_static_ip.suricato-iot.id
}

output "aws_lightsail_instance" {
    value = aws_lightsail_instance.suricato-iot.id
}