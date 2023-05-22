import socket
import os

# Cấu hình địa chỉ IP và cổng lắng nghe
ip_address = '192.168.3.104' #ip server na'y
port = 1234

# Tạo socket UDP
udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp_socket.bind((ip_address, port))

# Lắng nghe và xử lý gói tin UDP
while True:
    data, address = udp_socket.recvfrom(1024)
    command = data.decode()

    if command == 'shutdown':
        os.system('shutdown /s /f /t 0')
