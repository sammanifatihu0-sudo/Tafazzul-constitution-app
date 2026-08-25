# Constitution of India — Official Digital Reference Application

A clean, modern, high-performance, and offline-capable digital reference and reader application for the **Constitution of India (भारत का संविधान)**.

Designed for citizens, students, legal researchers, lawyers, and civil service aspirants.

---

## 🏛️ Key Features

### 1. 🔍 Instant Smart Search & Article Linking
- Search by **Article Number** (e.g. `14`, `19`, `21`, `21A`, `32`, `51A`, `368`, `370`), title, keyword, or constitutional concept (e.g. *freedom of speech*, *habeas corpus*, *untouchability*, *panchayat*, *emergency*).
- Typo-tolerant, multi-field search engine across Articles, Parts, Schedules, and the Preamble.
- **In-Text Cross-Article Linking:** Mentions of articles inside constitutional texts (e.g. references to Article 226 in Article 32) are automatically detected and rendered as clickable navigation links.

### 2. 📜 Authentic Official Text & Clear Separation of Information
- **Official Constitutional Text:** Sourced directly from the **Legislative Department, Ministry of Law and Justice, Government of India** and **India Code**.
- **Simplified Explanations:** Clearly demarcated educational plain-language guides to ensure high conceptual clarity without mixing AI/editorial content with authentic legal wording.
- **Key Takeaways & Points:** Summary bullets highlighting constitutional significance, judicial doctrines (e.g. *Basic Structure*, *Procedure Established by Law* vs *Due Process*, *Doctrine of Eclipse*), and landmark case laws.
- **Amendment History:** Chronological records of amendments for individual articles.

### 3. 📖 Dedicated Constitutional Sections
- **The Preamble:** Framed legal presentation with interactive glossary defining *Sovereign*, *Socialist*, *Secular*, *Democratic*, *Republic*, *Justice*, *Liberty*, *Equality*, and *Fraternity*.
- **All 25 Parts (I to XXII):** Union, States, Panchayats, Municipalities, Judiciary, Services, Elections, Emergency, Amendments, etc.
- **Schedules (1 to 12):** Territories, Oaths, Rajya Sabha seat allocation, Tribal areas, 7th Schedule legislative lists (Union, State, Concurrent), 8th Schedule official languages, 10th Schedule Anti-Defection, 11th & 12th Schedule local governance.
- **Fundamental Rights (Part III, Articles 12–35):** Categorized into Equality, Freedom, Protection against Exploitation, Freedom of Religion, Cultural & Educational Rights, and Constitutional Remedies.
- **Fundamental Duties (Part IVA, Article 51A):** Individual breakdown of all 11 duties `(a)` through `(k)`.
- **Directive Principles of State Policy (Part IV, Articles 36–51):** Grouped into Socialistic, Gandhian, and Liberal-Intellectual principles.
- **Constitutional Amendments:** Landmark amendments from the 1st Amendment (1951) to the 106th Amendment (Nari Shakti Vandan Adhiniyam, 2023).

### 4. 🛠️ Productivity, Offline & Accessibility Tools
- **100% Offline Capability:** Progressive Web App (PWA) with Service Worker and local database caching.
- **My Bookmarks:** Save important articles and reference points locally.
- **Recently Viewed:** Automatically tracks your reading history for quick resumption.
- **Bilingual Interface:** Instant toggle between English and Hindi (हिंदी).
- **Customizable Reader:** Font size scaling (`A-`, `A`, `A+`), theme toggle (Light / Dark mode), and print-optimized stylesheet for legal citation export.

### 5. 🔄 Data Management & Update Architecture
- Built-in **Data Manager & Schema Validator** (`#data-manager`) allows importing updated JSON datasets or new constitutional amendments without rebuilding the app.
- JSON Export/Download for backup and data analysis.

---

## 📁 Project Architecture & Directory Structure

```text
indian contitier/
├── index.html                   # Master application container and SEO metadata
├── manifest.json                # PWA manifest for mobile/desktop install
├── sw.js                        # Service Worker for 100% offline caching
├── README.md                    # Project documentation & reference guide
├── css/
│   └── style.css                # Premium minimal white-coded & dark design tokens
├── js/
│   ├── app.js                   # Client-side hash router and lifecycle controller
│   ├── data/
│   │   ├── constitution_data.js # Authoritative database (Parts, Schedules, Articles, Amendments)
│   │   └── hindi_translations.js# Bilingual Hindi glossary & translations
│   ├── services/
│   │   ├── storage.js           # LocalStorage service for bookmarks, history & preferences
│   │   └── db.js                # Search engine, auto-linker, query methods & validator
│   └── components/
│       ├── navbar.js            # Header, mobile drawer, theme & language switches
│       ├── search.js            # Live search input & filter chips
│       ├── home.js              # Home dashboard & quick access
│       ├── article-detail.js    # Article reader, official text, explanation & toolbelt
│       ├── articles-list.js     # Searchable, filterable all-articles directory
│       ├── preamble.js          # Preamble framed reader & glossary
│       ├── parts.js             # 25 Parts catalog
│       ├── schedules.js         # 12 Schedules viewer
│       ├── rights.js            # Part III Fundamental Rights explorer
│       ├── duties.js            # Part IVA Article 51A duties (a)-(k) explorer
│       ├── dpsp.js              # Part IV Directive Principles explorer
│       ├── amendments.js        # Landmark Amendments guide
│       ├── bookmarks.js         # Saved Bookmarks manager
│       ├── recent.js            # Recently Viewed history
│       ├── data-manager.js      # Admin data updater & JSON schema validator
│       └── about.js             # Official sources attribution & legal disclaimer
└── data/
    └── sample_amendment_import.json # Sample payload for updates
```

---

## 🚀 How to Run the Application

The application is built with **zero external runtime dependencies** (Vanilla HTML5, CSS3, and ES6+ JavaScript). It runs natively in any modern web browser.

### Option 1: Direct Browser Launch
Simply double-click or open [index.html](file:///c:/Users/ADMIN/Downloads/indian%20contitier/index.html) in Chrome, Edge, Safari, or Firefox.

### Option 2: Local Static Server (Optional)
If you prefer running through a local HTTP server:
```bash
# Using Python (if available):
python -m http.server 8080

# Using Node / npx (if available):
npx serve .
```
Then navigate to `http://localhost:8080` or the indicated port.

---

## ⚖️ Legal Information Disclaimer & Sources

**Authoritative Sources:**
1. **Primary Source:** Legislative Department, Ministry of Law and Justice, Government of India ([legislative.gov.in](https://legislative.gov.in)).
2. **Secondary Source:** India Code: Digital Repository of All Central and State Acts ([indiacode.nic.in](https://www.indiacode.nic.in)).

*Disclaimer: This application is intended for educational, academic research, civic awareness, and reference purposes. It is not a substitute for professional legal advice, official gazette notifications, or certified judicial filings.*
