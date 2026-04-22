Endpoint Session & Health Check Tool

Overview

A PowerShell script that runs manually or at user login to identify common session, access, and performance issues, then outputs a simple, easy-to-read health report.

🎯 Goal

Provide quick visibility into:

User permissions
Environment configuration
Connectivity status
Basic system health

🔍 Features

🧑‍💻 User & Environment Checks:

Determine if the current user is a local administrator
Detect whether the device is:
Domain-joined  or part of a workgroup

Identify session type:
Local or Remote (RDP)

🌐 RDP & Server Connectivity Checks
Verify if RDP is enabled on the machine
Test connectivity to a defined server using:
Ping (ICMP)

⚙️ Basic Performance Checks

Monitor CPU usage
Monitor memory usage
Check system uptime

🚀 Usage

Run manually:

.\endpoint-session-health-check-tool.ps1

Or configure to run at login via:

Task Scheduler
Group Policy (GPO)

📌 Notes
Designed for endpoint troubleshooting and quick diagnostics
Lightweight and fast execution
Can be extended with additional checks as needed
