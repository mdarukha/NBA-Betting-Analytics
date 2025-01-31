# 🏀 NBA Betting Analytics: Data-Driven Insights on Hoops & Odds 🎲📊

Welcome to **NBA Betting Analytics**, where we leverage **SQL, Tableau, and statistical analysis** to uncover key trends in **NBA team performance, betting spreads, and second-half dynamics**. Whether you're a **data scientist, sports bettor, or hoops fan**, this project delivers **actionable insights** from historical NBA betting data! 🏆🔥  

---

## 📌 Project Overview  
This project analyzes **NBA betting data from 2007–2024**, focusing on:  
✅ **Scoring trends**: How do teams' **regular-season vs. playoff margins** compare?  
✅ **Betting inefficiencies**: How often do **favorites fail to cover**?  
✅ **Second-half dynamics**: Which teams are **strong finishers**?  
✅ **Underdog upsets**: How often do **underdogs cover the spread**?  
✅ **Home-court advantage**: Does it **truly matter in the playoffs**?  

We achieve this using:  
- **SQL** for data querying & trend analysis  
- **MySQL** for structured data storage  
- **Tableau** for interactive visualizations 📊  
- **Python (Optional)** for future predictive modeling 🔮  

---

## 📂 Dataset  
The dataset, sourced from [Kaggle](https://www.kaggle.com/datasets/cviaxmiwnptr/nba-betting-data-october-2007-to-june-2024), includes:  
- **Game results** (scores, spreads, moneylines)  
- **Betting lines & results** (over/unders, favorite/underdog outcomes)  
- **Second-half lines** (tracking in-game adjustments)  

💾 The dataset has been **normalized into 7 tables** within a relational database to optimize analysis.  

---

## 🛠️ Key SQL Queries & Insights  
### 1️⃣ **Scoring Margins: Regular Season vs. Playoffs**  
📈 *Do teams with high scoring margins in the regular season perform better in the playoffs?*  
- ✅ **Trend:** Contenders like the **Warriors (2015-2019) & Heat (2011-2014)** had increasing playoff scoring margins.  
- 🔥 **Key takeaway:** A strong **regular-season margin** may signal **deep playoff success**!  

### 2️⃣ **Favorites Failing to Cover the Spread**  
📊 *How often do favorites fail to cover?*  
- ✅ **Finding:** A steady **increase in favorites failing to cover**, eclipsing **35% in 2023**.  
- 🎯 **Takeaway:** The NBA is becoming **more competitive**, making underdog bets **more valuable**.  

### 3️⃣ **Second-Half Surprises: Underdogs Covering H2 But Not Full Game**  
⏳ *Are some teams “2nd-half risers”?*  
- ✅ **Finding:** Denver Nuggets **frequently outperform** in the **2nd half** due to clutch players.  
- 🏆 **Key takeaway:** If a team **covers the 2nd-half spread**, they **likely cover full-game too**!  

### 4️⃣ **Home vs. Away Scoring Differences in Playoffs**  
🏟️ *Does home-court advantage really matter?*  
- ✅ **Finding:** **Celtics, Warriors, and 76ers** consistently had **10+ point home advantages** in playoffs.  
- 📢 **Takeaway:** Some arenas **genuinely impact performance** (crowd intensity, travel fatigue, etc.).  

---

## 📊 Tableau Visualizations  
To make the data **interactive & insightful**, we've built:  
- 🏀 **Scoring Margin Trends Dashboard**  
- 🎲 **Betting Success & Failures by Team**  
- 🔥 **Second-Half vs. Full-Game Betting Analysis**  
- 🏟️ **Home vs. Away Scoring Insights**  

🚀 **Check them out in the repo screenshots!**  

---

## 🚀 How to Run the Project  
### **1️⃣ Set Up MySQL & Import Data**  
```sh
mysql -u your_username -p < nba_db.sql
```

### **2️⃣ Run SQL Queries**
Use the queries.sql file to explore trends in betting performance, scoring differentials, and team trends.
```sh
mysql -u your_username -p nba_db < Business Questions SQL Queries.sql
```

### **3️⃣ Explore Visualizations in Tableau**
- Open Workbook with all Visualizations.twb in Tableau Public
- Customize filters to uncover your own betting insights!

---

## 🏆 Future Work
- 🔮 **Predictive Modeling**: Can we predict betting spreads using machine learning?
- 📊 **Expanded Visualizations**: Deeper look at player stats affecting betting trends.
- ⚡ **Automated Dashboard**: Real-time updates with new game data!
 
 ---
 
## 🤝 Contributing
Want to improve the analysis? Fork the repo & submit a PR! 🚀

- 👨‍💻 Author: Malcolm Darukhanawalla
- 📧 Contact: mdarukha@ucdavis.edu
