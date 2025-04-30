# 🚀 CI/CD Pipeline with GitHub Actions & Docker (No Cloud)

This project demonstrates a complete **CI/CD pipeline** using:
- **GitHub Actions** for automation  
- **Docker** for containerization  
- **Docker Hub** for image hosting  
- **Local deployment** using `docker run` (no cloud or Kubernetes needed)

---

## 📦 Project Structure

```
.
├── .github/workflows/ci-cd.yml        # GitHub Actions CI/CD pipeline
├── CI-CD Pipeline with GitHub...      # App source code (Node.js)
│   ├── Dockerfile
│   ├── server.js
│   └── package.json
```

---

## ⚙️ Technologies Used

- **Node.js**: Simple Express web server  
- **Docker**: Containerize the app  
- **GitHub Actions**: CI/CD pipeline  
- **Docker Hub**: Image registry  
- **curl**: Healthcheck
  
---

## 📁 Setup

### 🔧 1. Clone this repo

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### 🔧 2. Add Docker Hub secrets to GitHub

Go to **Settings > Secrets > Actions** and add:

- `DOCKER_USERNAME`  
- `DOCKER_PASSWORD`

---

## 🚀 GitHub Actions CI/CD Workflow

Triggered automatically on **push to `main`** branch:

1. ✅ Checkout source code  
2. ✅ Build Docker image using `Dockerfile`  
3. ✅ Push image to Docker Hub  
4. ✅ Run the image locally using `docker run`  
5. ✅ Use `curl` to test the app on `localhost:2000`  
6. ✅ Clean up the container  

> ℹ️ For external access to `localhost:2000`, use a **self-hosted runner**.

---

## 🐳 Running the App Locally

To test the deployed image on your own system:

```bash
docker pull your-dockerhub-username/my-app:latest
docker run -d -p 2000:2000 --name my-app your-dockerhub-username/my-app:latest
```

Open your browser at:

```
http://localhost:2000
```

---

## 🧪 Example Output

After a successful push, GitHub Actions will:
- Build the image  
- Push to Docker Hub  
- Run `curl` test to verify it's live  
- Show results in the **Actions tab**

![image](https://github.com/user-attachments/assets/b89a007d-42e9-426d-82f4-e30d332d0720)

---

## 🧹 Cleanup

To stop and remove the local container:

```bash
docker stop my-app
docker rm my-app
```

---

## 📌 Notes

- If you're using GitHub-hosted runners, `localhost:2000` is **not accessible** from your browser.  
- To test the live app via browser, use a **self-hosted runner** or run the image on your machine.

---
