
README GLB

LAB 👍

Think of a **Global HTTP Load Balancer** as a pipeline:

**Client → Anycast IP → Forwarding Rule → Target Proxy → URL Map → Backend Service → Instance Groups → VMs**

---

## 🌍 Global Entry Point

### **135. Create global static IP (Anycast)**

**Why:**
Gives you **one global IP** reachable worldwide. Google routes users to the **nearest healthy region** automatically.

---

### **136. Verify global IP**

**Why:**
Confirm IP was created and note it for DNS or testing.

---

## ❤️ Health & Backend Logic

### **137. Create global HTTP health check**

**Why:**
The load balancer **must know which VMs are healthy**.
Only healthy instances receive traffic.

---

### **138. Create global backend service**

**Why:**
Backend service is the **logical container** that:

* Holds instance groups
* Applies health checks
* Controls load balancing behavior

---

## 🌍 Multi-Region Awareness

### **139. Check region availability zones**

**Why:**
Ensures you create resources in **valid zones** for that region.

---

### **140. Start existing instances**

**Why:**
Load balancer can only route traffic to **running VMs**.

---

## 🖥️ Backend Compute (Germany region)

### **141–142. Create web3 & web4 VMs**

**Why:**
These are your **actual web servers** that will serve HTTP traffic.

---

## 📦 Instance Groups (Required by LB)

### **143. Create unmanaged instance group (web3)**

**Why:**
HTTP(S) Load Balancers **cannot point directly to VMs**.
They require **instance groups**.

---

### **144. Add web3 to its group**

**Why:**
Registers the VM as a **load-balanced backend**.

---

### **145–146. Repeat for web4**

**Why:**
Enables **horizontal scaling and redundancy** within a region.

---

## ❤️ Health Check ()

### **Create health check (web-hc)**

**Why:**
Same reason as earlier:
Backend service **must reference a health check** to function.


---

## 📦 Backend Service (Core Component)

### **Create backend service**

**Why:**
This is the **brain of the load balancer**:

* Knows *how* to send traffic
* Knows *where* to send traffic
* Knows *who is healthy*

---

## 🔗 Attach Compute to Backend

### **147–148. Add instance groups to backend**

**Why:**
This step **connects real servers to the LB**.
Without this → backend exists but serves nothing.

---

## 🧭 Traffic Routing Logic

### **149. Create URL map**

**Why:**
Defines **routing rules** (path-based, host-based).
Even simple setups require one.

---

### **150. Create HTTP target proxy**

**Why:**
Terminates HTTP connections and:

* Applies URL map logic
* Forwards traffic to backend service

---

## 🚦 Public Exposure

### **151. Create global forwarding rule**

**Why:**
Binds:

* Global IP
* Port 80
* Target proxy

This is what makes the load balancer **publicly reachable**.

---

### **152. Verify forwarding rules**

**Why:**
Ensures the LB is:

* Global
* Listening
* Correctly attached

---

## 🔍 Validation & Testing

### **153. List running instances**

**Why:**
Confirms all backends are **up and ready**.

---

### **154. Test load balancer**

**Why:**
Verifies:

* Traffic reaches the LB
* Requests are distributed
* No timeouts or failures

---

### **155. Check backend health**

**Why:**
Confirms LB sees instances as **HEALTHY**.
Unhealthy backends receive **zero traffic**.

---

## 🌐 Application Layer

### **156–157. Install nginx**

**Why:**
Provides actual HTTP content so:

* Health checks succeed
* Clients receive real responses

---

## 🧠 One-Line Architecture Summary

| Component       | Purpose                      |
| --------------- | ---------------------------- |
| Global IP       | Single worldwide entry point |
| Forwarding Rule | Listens on port 80           |
| Target Proxy    | Handles HTTP                 |
| URL Map         | Routing logic                |
| Backend Service | Load balancing brain         |
| Health Check    | Determines health            |
| Instance Groups | Backend targets              |
| VMs             | Serve content                |

---

