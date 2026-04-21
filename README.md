Endpoint Session & Health Check Tool

Goal:
A Powershell script that runs manually or at login to check whether the user’s machine has common session, access, and performance issues, then outputs a simple health report.

Keep these features

1. User and environment checks

	- Check whether the current user is a local admin 
	- Check whether the device is domain-joined or in a workgroup 
	- Check whether the session is local or remote/RDP  

2. RDP and server connectivity checks

	- Check whether RDP is enabled on the machine 
	- Check whether the machine can reach a defined server with a ping test 
	- Optionally test whether a common server port is reachable 

3. Basic performance checks

	- Check CPU usage 
	- Check memory usage 
	- Check system uptime 
	- Flag if uptime is too high and suggest restart 
