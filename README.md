# WTFridge

**🍳Scan. Laugh. Cook.**  

A Flutter app that **detects food items from images** (like your sad fridge contents) and suggests **quick, lazy-friendly recipes**—perfect for students, hostel dwellers, and busy professionals who'd rather not adult today.  

<p align="center">
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDk5d2VjZGJmY2VvbmV2Z3R0Y2J6eWx6Z2h1dWx0ZGd5d2R6eWZ5biZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0HU7JI8WKhwsQqO4/giphy.gif" width="300" alt="App Demo">
</p>

---

## 🔥 Features  
- **AI-Powered Food Detection**  
  - Uses **Google Cloud Vision API** to identify even questionable fridge items (*"Is that cheese or soap?"*).  
- **Lazy Recipe Suggestions**  
  - Get **3-step recipes** based on what you scanned (*because who has time for 20 ingredients?*).  
- **Offline Survival Mode**  
  - Preloaded **ramen hacks** and **microwave miracles** for when the internet (or your will to live) dies.  
- **Broke Student Mode**  
  - Filters recipes by **cost** (*"Show me recipes under $2"*).  

---

## 🛠️ Tech Stack  
- **Flutter** (iOS + Android)  
- **Firebase** (Auth + Firestore for recipes)  
- **Google Cloud Vision API** (Food detection)  
- **Spoonacular API** (Optional: 1,000 free recipe calls/month)  

---

## 🚀 How It Works  
1. 📸 **Scan** your fridge/food item.  
2. 🤖 **AI detects ingredients** (even the sketchy ones).  
3. 🍜 **Get recipes** sorted by laziness level.  
4. 🎉 **Pretend you’re a chef** (or just eat straight from the pan).  

---

## 📦 Installation  
```bash  
# Clone the repo  
git clone https://github.com/yourusername/WhatTheFood.git  

# Install dependencies  
flutter pub get  

# Run the app  
flutter run  
