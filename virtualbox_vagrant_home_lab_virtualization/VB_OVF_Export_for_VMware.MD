

# ✅ **Recommended Export Format**

When you export in VirtualBox:

**File → Export Appliance (OVF)**

Choose:

### ✔ **OVF 2.0**

**Do NOT use OVF 1.0** (VMware often rejects it or errors during import).

### ✔ Disk Format: **VMDK**

VMware uses VMDK natively.
VirtualBox will suggest VMDK automatically—keep that.

---

# ✅ **Settings to Adjust Before Export**

### ### **1. Storage Controller**

VMware prefers:

* **SCSI (LSI Logic)**
  or
* **SATA**

But **avoid VirtualBox-only controllers**:

❌ ICH9
❌ VirtIO
❌ VBox internal controllers

So in the VM settings before exporting, change:

**Settings → Storage → Controller**
✔ Use **SATA** or **SCSI (LSI Logic)**

This prevents import errors in VMware.

---

# ### **2. Remove or disable VirtualBox extensions/tools**

Inside the Windows Server VM:

* Uninstall **VirtualBox Guest Additions**
  (VMware Tools will replace it later)

Not mandatory for export but prevents driver/boot problems.

---

# ### **3. Network Adapter**

Set adapter to:

✔ **Intel PRO/1000 MT Server**

VMware recognizes this automatically.

Avoid:
❌ Paravirtualized network (virtio-net)
❌ PCnet adapters

---

# ### **4. CPU and Chipset**

Recommended:

* Chipset: **PIIX3**
* CPU: **1–4 cores**
* Enable:
  ✔ IO APIC
  ✔ Hardware virtualization (VT-x/AMD-V)

Avoid:
❌ "KVM" or other paravirtualization modes

Use:
✔ Paravirtualization Interface = **Default** or **None**

---

# ### **5. Export Options**

When VirtualBox asks for export settings:

### Set the following:

| Setting                   | Recommended Value                     |
| ------------------------- | ------------------------------------- |
| **Format**                | OVF 2.0                               |
| **Disk Format**           | VMDK                                  |
| **MAC Address Policy**    | Include MAC or Generate new (both ok) |
| **Manifest**              | Optional                              |
| **Appliance Compression** | OVA or OVF folder (your choice)       |

If you want a **single file**, choose **OVA**.

---

# 🔧 After Export — Import Into VMware

In VMware (Workstation, Fusion, or ESXi):

**File → Open** → select the `.ova` or `.ovf`.

VMware will automatically convert and create its own VM files.

Then install VMware Tools inside Windows Server.

---

