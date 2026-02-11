[nginx]
%{ for ip in servers ~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}
%{ endfor ~}
