# **LXR-PoliceJob** 🚔  
**Comprehensive Police Job for RedM using the LXRCore Framework**

![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)  
![Build](https://img.shields.io/badge/Build-Stable-blue)  
![License](https://img.shields.io/badge/License-MIT-green)  
![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-orange)  
![Platform](https://img.shields.io/badge/Platform-RedM-black)  
![Framework](https://img.shields.io/badge/Framework-LXRCore-blue)

## **Introduction**  
This is the ultimate **Police Job** resource for RedM powered by the **LXRCore Framework**. It includes law enforcement roles, evidence collection, police stations, armory systems, and much more. With this system, players can immerse themselves fully in the world of law enforcement.

---

## **Features**

- **Blips and Job Markers**: Configurable blips for law enforcement jobs and important locations.
- **Duty Management**: Access different police stations and switch on or off duty.
- **Evidence System**: Collect evidence at crime scenes within a specific range.
- **Armory**: Access police armories to equip weapons and supplies.
- **Player Interaction**: Arrest, fine, and manage civilians through the police menu.
- **Custom Locations**: Fully configurable police station locations, armory, evidence collection, and stash points.
- **Vehicle Interactions**: Supports whitelisted police vehicles.

---

## **Installation**

### **Step 1: Download & Extract**
1. Download the script and extract it to your server’s `resources` folder.
2. Place the extracted folder under `[lxr]`.

### **Step 2: Add to Server Config**
Add the following lines to your `server.cfg` or `resources.cfg`:

```bash
ensure lxr-core
ensure lxr-policejob
```

### **Step 3: SQL Integration**
Import the provided `lxr-policejob.sql` into your server’s database.

### **Step 4: Configure**
Customize your `config.lua` to suit your server’s needs. All locations, jobs, items, and ranks can be modified.

---

## **Configurable Features**

### **Blip and Job Configurations**
```lua
Config.ShowBlips = true

Config.EvidenceJobs = {
    police = true
}
Config.BlipsJobs = {
    police = true, 
    ambulance = true
}
Config.Law = {
    police = true, 
    sheriff = true
}
```
- **BlipsJobs**: Define jobs that will have blips visible on the map.
- **EvidenceJobs**: Define jobs authorized to interact with the evidence system.

### **Locations**  
You can configure the locations for police stations, duty points, armories, evidence storage, and more.

```lua
Config.Locations = {
    duty = {
        vector3(1362.05, -1301.83, 77.77),  -- Valentine
        vector3(2507.53, -1301.41, 48.95),  -- Saint Denis
        vector3(-768.03, -1266.37, 44.05),  -- Blackwater
        vector3(-1812.03, -354.09, 164.65)  -- Strawberry
    },
    armory = {
        vector3(1361.16, -1305.7, 77.76),
        vector3(2494.53, -1304.32, 48.95),
        vector3(-764.86, -1272.43, 44.04),
        vector3(-1813.93, -354.78, 164.65)
    },
    stations = {
        { label = "Sheriff", coords = vector3(1360.88, -1301.53, 77.77) },
        { label = "Saint Denis Police Dept. HQ", coords = vector3(2501.83, -1309.04, 48.95) },
        { label = "Blackwater Police Dept.", coords = vector3(-760.47, -1269.14, 44.04) },
        { label = "Strawberry Sheriff", coords = vector3(-1810.57, -350.91, 164.66) }
    }
}
```
- You can add or modify these locations to fit the roleplay map of your server.

### **Armory Items Configuration**  
Set up different items in the police armory, from weapons to ammo and specialized tools.

```lua
Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info = { serie = "" },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info = { serie = "" },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        }
    }
}
```
- **AuthorizedJobGrades**: This allows specific job grades (e.g., ranks) to access the items.

### **Evidence System**
The evidence system allows officers to interact with objects placed at crime scenes. The range for collecting evidence is configurable.

```lua
Config.EvidenceRange = 2.5  -- Range for interacting with evidence
```

---

## **Usage**

1. **Go On Duty**: Players can go on or off duty at any configured **duty point**.
2. **Access Armory**: Officers can access the police armory and equip authorized weapons.
3. **Collect Evidence**: Officers can collect evidence at crime scenes within the specified range.
4. **Manage Civilians**: Use police interaction menus to handle arrests, fines, and investigations.
5. **Whitelisted Vehicles**: Access specific police vehicles through the armory or vehicle interaction menu.

---

## **Dependencies**
- [**LXRCore**](https://github.com/LXRCore/lxr-core): The main framework powering this police job resource.
- [**lxr-inventory**](https://github.com/LXRCore/lxr-inventory): Required for inventory and item management.

---

## **License**
```
LXRCore Framework
Copyright (C) 2024 iBoss

This program is free software: you can redistribute it and/or modify
it under the terms of the MIT License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

---

## **Contributions**
Contributions are welcome! If you have any suggestions or improvements, feel free to submit pull requests or open issues in the GitHub repository.
