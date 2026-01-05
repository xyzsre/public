
INFO

**create a GCP service account key (JSON)**
**use it to authenticate the Google Cloud CLI on Ubuntu**
**clear step-by-step guide**


---

## PART 1: Create a Service Account & JSON Key (GCP Console)

### Step 1: Open GCP Console

1. Go to **[https://console.cloud.google.com](https://console.cloud.google.com)**
2. Make sure the **correct project** is selected (top bar)

---

### Step 2: Go to Service Accounts

1. Open the menu ☰
2. Navigate to
   **IAM & Admin → Service Accounts**

---

### Step 3: Create a Service Account (if you don’t already have one)

1. Click **Create Service Account**
2. **Service account name**:
   Example: `ubuntu-cli-access`
3. Click **Create and Continue**

---

### Step 4: Assign Permissions

Choose roles based on what you need. Common ones:

* **Editor** (simple but broad)
* OR more secure:

  * `Compute Admin`
  * `Storage Admin`
  * `Viewer`

➡️ Click **Continue** → **Done**

---

### Step 5: Create the JSON Key

1. Click on the **service account you just created**
2. Go to the **Keys** tab
3. Click **Add Key → Create new key**
4. Select **JSON**
5. Click **Create**

📥 A `.json` file will be downloaded — **keep it secure**

---

## PART 2: Install Google Cloud CLI on Ubuntu

### Step 6: Install gcloud CLI

Run these commands on Ubuntu:

```bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates gnupg curl
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update
sudo apt install -y google-cloud-cli
```

Verify:

```bash
gcloud version
```

---

## PART 3: Authenticate Using the JSON Key

### Step 7: Move the Key File Securely

Example:

```bash
mkdir -p ~/.gcp
mv ~/Downloads/my-key.json ~/.gcp/
chmod 600 ~/.gcp/my-key.json
```

---

### Step 8: Authenticate with the Service Account

```bash
gcloud auth activate-service-account --key-file=~/.gcp/my-key.json
```

You should see:

```
Activated service account credentials for: [service-account@project.iam.gserviceaccount.com]
```

---

### Step 9: Set the Project

```bash
gcloud config set project YOUR_PROJECT_ID
```

Check:

```bash
gcloud config list
```

---

### Step 10: Test Authentication

```bash
gcloud projects list
```

or:

```bash
gcloud compute instances list
```

---

## OPTIONAL (Best Practice)

Set the key as an environment variable:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/.gcp/my-key.json
```

Add to `.bashrc`:

```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS=~/.gcp/my-key.json' >> ~/.bashrc
```

---

## Security Tips 🚨

* ❌ Never commit the JSON key to Git
* 🔐 Rotate keys regularly
* 🧾 Delete unused keys

---



