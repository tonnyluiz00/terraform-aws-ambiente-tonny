output "public_ip" {
    description = "IPs Publicos"
#    value = {for instance in aws_instance.this : instance.tags["Name"] => instance.public_ip }
#   value = {for key, instance in aws_instance.this : key => instance.public_ip }
#    value = {for instance in aws_instance.this : instance.tags["Env"] => instance.public_ip... }
     value       = aws_instance.this.public_ip    

}