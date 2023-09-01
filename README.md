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
### Show menu of options
```
.\CLSID-Ninja.ps1 -Search Menu
```
<details>
  <summary>Click to see screenshot</summary>

![image](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/cd74d059-0ffb-459e-ab66-c6efc481e314)

</details> <br />


### Show all users CLSID
```
.\CLSID-Ninja.ps1 -Search All
```
<details>
  <summary>Click to see screenshot</summary>
  
![image](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/8f58c499-2230-4a01-80da-29cce37c5357)

</details> <br />

### Search for specific CLSID on all the users on the host
```
.\CLSID-Ninja -Search CLSID "{PUT-YOUR-CLSID}"
Example: .\CLSID-Ninja -Search CLSID ""{0003000A-0000-0000-C000-000000000046}"
```
<details>
  <summary>Click to see screenshot</summary>
  
![image](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/b8638239-0e37-4cd9-a6c6-31ef2a0e1f65)

</details>

## 🦅 Example for running tool on Falcon Crowdstrike

<details>
  <summary>Click to see video</summary>
  <br />
The first line of code, is to bypass the execution policy so you can run script on the system.

```
Set-ExecutionPolicy b p
```

<br />

![Example for CS](https://github.com/YosfanEilay/CLSID-Ninja/assets/132997318/7360cdf7-3b09-40c5-9b4c-5158cae87650)
