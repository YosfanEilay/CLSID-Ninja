# 🥷🏻 CLSID-Ninja

![CLSID Ninja](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/120b5ee7-9ad6-48f6-929a-0a4e940f705b)

## 📜 Tool Description
Your PowerShell-powered solution for effortless CLSID analysis! Designed for Threat Researchers and Malware Analysts,
this tool simplifies the process of extracting and inspecting users' CLSID registry values. Easily identify potential
threats and malicious activity by examining COM Objects for compromise or replacement by malware. CLSID Ninja offers
a comprehensive view, allowing you to access CLSID lists for both online (Active Users) and offline users by loading
UsrClass.DAT files into the HKLM hive. Streamline your analysis with CLSID Ninja today!

## 📐 Compatibility
Working with EDR's? not a problem! <br />
CLSID Ninja is designed to seamlessly integrate into your workflow: <br />
+ **Local Host:** CLSID Ninja can be run locally on the host itself.
+ **Cortex XDR Live Terminal:** Easily execute CLSID Ninja within the Cortex XDR Live Terminal, enhancing your threat analysis capabilities.
+ **Falcon Crowdstrike RTR:** Extend your threat detection and response capabilities with CLSID Ninja in Falcon Crowdstrike RTR,
  ensuring effective CLSID analysis directly within the platform. <br />

Tested on: Windows 10, Windows 11.

## ✏️ How to Run
Show menu of options
```
.\CLSID-Ninja.ps1 -Search Menu
```
![image](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/41f1df18-757f-490a-ae96-da32f435f629)

Show all users CLSID
```
.\CLSID-Ninja.ps1 -Search All
```

Search for specific CLSID on all the users on the host
```
.\CLSID-Ninja -Search CLSID "{PUT-YOUR-CLSID}"
Example: .\CLSID-Ninja -Search CLSID ""{0003000A-0000-0000-C000-000000000046}"
```
