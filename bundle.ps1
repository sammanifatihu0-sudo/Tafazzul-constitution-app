$base = $PSScriptRoot

# Read CSS
$css = [System.IO.File]::ReadAllText((Join-Path $base "css\style.css"), [System.Text.Encoding]::UTF8)

# Read all JS files in correct dependency order
$jsFiles = @(
  "js\data\constitution_data.js",
  "js\data\hindi_translations.js",
  "js\services\storage.js",
  "js\services\i18n.js",
  "js\services\supabase.js",
  "js\services\db.js",
  "js\components\navbar.js",
  "js\components\search.js",
  "js\components\article-detail.js",
  "js\components\preamble.js",
  "js\components\parts.js",
  "js\components\articles-list.js",
  "js\components\schedules.js",
  "js\components\rights.js",
  "js\components\duties.js",
  "js\components\dpsp.js",
  "js\components\amendments.js",
  "js\components\bookmarks.js",
  "js\components\recent.js",
  "js\components\data-manager.js",
  "js\components\about.js",
  "js\components\home.js",
  "js\app.js"
)

$combinedJs = ""
foreach ($file in $jsFiles) {
  $filePath = Join-Path $base $file
  if (Test-Path $filePath) {
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $combinedJs += "`n// --- $file ---`n" + $content + "`n"
  }
}

# Mobile Frame & Fullscreen layout fixes to ensure perfect mobile experience on phone & desktop
$layoutFixCss = @"
/* === LAYOUT & RESPONSIVE FIXES === */
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  min-height: 100%;
  background-color: var(--app-bg);
  font-family: var(--font-sans);
  color: var(--text-primary);
  overflow-x: hidden;
}

.app-wrapper {
  width: 100%;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 0;
  box-sizing: border-box;
}

.app-wrapper.mobile-frame-mode {
  padding: 1.5rem 0;
}

@media (max-width: 640px) {
  .device-switcher-bar {
    display: none !important;
  }
  .app-wrapper.mobile-frame-mode {
    padding: 0 !important;
  }
}

.app-screen {
  width: 100%;
  max-width: 440px;
  min-height: 100vh;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--screen-bg);
  position: relative;
  overflow: hidden;
  box-shadow: 0 10px 25px rgba(0,0,0,0.08);
}

.app-wrapper.fullscreen-mode .app-screen {
  max-width: 100%;
  box-shadow: none;
}

@media (max-width: 640px) {
  .app-screen {
    max-width: 100% !important;
    height: 100vh !important;
    border-radius: 0 !important;
    box-shadow: none !important;
  }
}

.app-topbar {
  height: 60px;
  min-height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 1rem;
  background-color: var(--surface-primary);
  border-bottom: 1px solid var(--border-color);
  z-index: 40;
  flex-shrink: 0;
}

.app-viewport {
  flex: 1;
  overflow-y: auto;
  padding: 1rem;
  padding-bottom: 5rem;
  -webkit-overflow-scrolling: touch;
  background-color: var(--screen-bg);
}

.app-bottom-nav {
  height: 60px;
  min-height: 60px;
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  align-items: center;
  justify-content: space-around;
  background-color: var(--surface-primary);
  border-top: 1px solid var(--border-color);
  z-index: 50;
  flex-shrink: 0;
}
"@

$finalHtml = @"
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <title>TAFAZZUL Constitution</title>
  
  <!-- PWA & Mobile App Meta Tags -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-title" content="TAFAZZUL Constitution">
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="theme-color" content="#ffffff">
  <link rel="manifest" href="manifest.json">

  <!-- Typography -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Merriweather:ital,wght@0,300;0,400;0,700;1,300&display=swap" rel="stylesheet">
  
  <!-- Embedded High-Performance Stylesheet -->
  <style>
$css

$layoutFixCss
  </style>
</head>
<body class="app-body">
  <!-- Desktop Device Preview Switcher -->
  <div class="device-switcher-bar" id="deviceSwitcherBar">
    <div class="switcher-content">
      <span class="switcher-label">App View:</span>
      <button id="viewMobileBtn" class="switcher-btn active" title="Mobile App View">
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
        Mobile Frame
      </button>
      <button id="viewFullBtn" class="switcher-btn" title="Full Screen Responsive View">
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
        Full Screen
      </button>
    </div>
  </div>

  <!-- App Shell Container -->
  <div class="app-wrapper mobile-frame-mode" id="appWrapper">
    <div class="app-screen" id="appScreen">
      
      <!-- Native Mobile Top App Bar -->
      <header class="app-topbar" id="appTopbar">
        <div class="topbar-left">
          <!-- Back button -->
          <button id="topbarBackBtn" class="topbar-icon-btn back-btn" aria-label="Go Back" style="display: none;">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <line x1="19" y1="12" x2="5" y2="12"></line>
              <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
          </button>
          
          <div class="topbar-brand" id="topbarBrand">
            <div class="app-logo-badge">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
                <path d="M2 17l10 5 10-5"></path>
                <path d="M2 12l10 5 10-5"></path>
              </svg>
            </div>
            <div class="topbar-title-wrap">
              <h1 class="topbar-title" id="topbarTitle">TAFAZZUL Constitution</h1>
              <span class="topbar-subtitle" id="topbarSubtitle">India • Official App</span>
            </div>
          </div>
        </div>

        <div class="topbar-right">
          <!-- Quick Article Number Jump Pad Button -->
          <button id="jumpPadBtn" class="topbar-icon-btn" title="Quick Jump by Article #" aria-label="Jump to Article Number">
            <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="4" y1="9" x2="20" y2="9"></line>
              <line x1="4" y1="15" x2="20" y2="15"></line>
              <line x1="10" y1="3" x2="8" y2="21"></line>
              <line x1="16" y1="3" x2="14" y2="21"></line>
            </svg>
          </button>

          <!-- Language Selector Button -->
          <button id="langModalTriggerBtn" class="topbar-icon-btn lang-pill-btn" title="Change Language / भाषा बदलें" aria-label="Change Language">
            <span style="margin-right: 2px;">🌐</span>
            <span id="langIndicator">EN</span>
          </button>

          <!-- Dark / Light Theme -->
          <button id="themeToggleBtn" class="topbar-icon-btn" title="Toggle Theme" aria-label="Toggle Theme">
            <svg class="sun-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
            <svg class="moon-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
          </button>

          <!-- More Options Menu -->
          <button id="moreMenuBtn" class="topbar-icon-btn" title="More Menu" aria-label="More Menu">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="1"></circle>
              <circle cx="12" cy="5" r="1"></circle>
              <circle cx="12" cy="19" r="1"></circle>
            </svg>
          </button>
        </div>
      </header>

      <!-- Scrollable App Content Viewport -->
      <main class="app-viewport" id="appContent" role="main">
        <!-- Views render dynamically here -->
      </main>

      <!-- Native Bottom Navigation Tab Bar -->
      <nav class="app-bottom-nav" id="appBottomNav">
        <a href="#home" class="nav-tab active" data-tab="home">
          <div class="tab-icon">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
              <polyline points="9 22 9 12 15 12 15 22"></polyline>
            </svg>
          </div>
          <span class="tab-label" id="tabHomeLabel">Home</span>
        </a>

        <a href="#parts" class="nav-tab" data-tab="parts">
          <div class="tab-icon">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="3" width="7" height="7"></rect>
              <rect x="14" y="3" width="7" height="7"></rect>
              <rect x="14" y="14" width="7" height="7"></rect>
              <rect x="3" y="14" width="7" height="7"></rect>
            </svg>
          </div>
          <span class="tab-label" id="tabPartsLabel">Parts</span>
        </a>

        <a href="#articles" class="nav-tab" data-tab="articles">
          <div class="tab-icon">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
          </div>
          <span class="tab-label" id="tabSearchLabel">Search</span>
        </a>

        <a href="#fundamental-rights" class="nav-tab" data-tab="fundamental-rights">
          <div class="tab-icon">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
            </svg>
          </div>
          <span class="tab-label" id="tabRightsLabel">Rights</span>
        </a>

        <a href="#bookmarks" class="nav-tab" data-tab="bookmarks">
          <div class="tab-icon tab-badge-wrap">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path>
            </svg>
            <span class="tab-badge" id="bottomNavBookmarkBadge" style="display: none;">0</span>
          </div>
          <span class="tab-label" id="tabSavedLabel">Saved</span>
        </a>
      </nav>

      <!-- Multi-Language Selector Modal Dialog -->
      <div class="jump-modal" id="languageModal">
        <div class="jump-scrim" id="languageScrim"></div>
        <div class="jump-box" style="max-height: 80vh; display: flex; flex-direction: column;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
            <h3 class="jump-title" style="margin-bottom: 0;">🌐 Choose Language / भाषा चुनें</h3>
            <button id="closeLangModalBtn" style="font-size: 1.5rem; line-height: 1; color: var(--text-muted);">&times;</button>
          </div>
          <p class="jump-desc">Select your preferred language for reading the Constitution:</p>
          
          <div class="language-picker-grid" id="langListContainer" style="overflow-y: auto; flex: 1; margin-bottom: 1rem; max-height: 320px; display: flex; flex-direction: column; gap: 0.4rem;">
            <!-- Language items populated dynamically -->
          </div>

          <div style="text-align: right;">
            <button id="langModalDoneBtn" class="app-btn-primary" style="width: 100%;">Apply Language / भाषा लागू करें</button>
          </div>
        </div>
      </div>

      <!-- App Bottom Sheet Menu (More Options) -->
      <div class="bottom-sheet" id="moreBottomSheet">
        <div class="sheet-scrim" id="sheetScrim"></div>
        <div class="sheet-panel">
          <div class="sheet-handle"></div>
          <div class="sheet-header">
            <h3 class="sheet-title" id="sheetMenuTitle">App Menu</h3>
            <button class="sheet-close" id="sheetCloseBtn">&times;</button>
          </div>
          <div class="sheet-links">
            <a href="#preamble" class="sheet-item">
              <span class="sheet-item-icon">📜</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetPreambleTitle">The Preamble</span>
                <span class="sheet-item-desc">Sovereign, Socialist, Secular Republic values</span>
              </div>
            </a>
            <a href="#schedules" class="sheet-item">
              <span class="sheet-item-icon">📑</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetSchedulesTitle">Schedules (1 to 12)</span>
                <span class="sheet-item-desc">Official languages, powers, and oaths</span>
              </div>
            </a>
            <a href="#fundamental-duties" class="sheet-item">
              <span class="sheet-item-icon">⭐</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetDutiesTitle">Fundamental Duties (51A)</span>
                <span class="sheet-item-desc">11 Civic duties of citizens</span>
              </div>
            </a>
            <a href="#dpsp" class="sheet-item">
              <span class="sheet-item-icon">🏛️</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetDpspTitle">Directive Principles (DPSP)</span>
                <span class="sheet-item-desc">Part IV state welfare policies</span>
              </div>
            </a>
            <a href="#amendments" class="sheet-item">
              <span class="sheet-item-icon">⚖️</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetAmendmentsTitle">Constitutional Amendments</span>
                <span class="sheet-item-desc">From 1st to 106th Amendment</span>
              </div>
            </a>
            <a href="#recent" class="sheet-item">
              <span class="sheet-item-icon">🕒</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title">Recently Viewed</span>
                <span class="sheet-item-desc">Your reading history</span>
              </div>
            </a>
            <a href="#data-manager" class="sheet-item">
              <span class="sheet-item-icon">🔄</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title">Data Management & Import</span>
                <span class="sheet-item-desc">Update official constitutional data</span>
              </div>
            </a>
            <a href="#about" class="sheet-item">
              <span class="sheet-item-icon">ℹ️</span>
              <div class="sheet-item-text">
                <span class="sheet-item-title">About & Legal Disclaimer</span>
                <span class="sheet-item-desc">Legislative Dept. source attribution</span>
              </div>
            </a>
          </div>
        </div>
      </div>

      <!-- Quick Article Jump Dialog Modal -->
      <div class="jump-modal" id="jumpModal">
        <div class="jump-scrim" id="jumpScrim"></div>
        <div class="jump-box">
          <h3 class="jump-title">Jump to Article Number</h3>
          <p class="jump-desc">Enter any Article number (e.g. 14, 19, 21, 21A, 32, 51A, 226, 368, 370)</p>
          <div class="jump-input-wrap">
            <span class="jump-prefix">Article</span>
            <input type="text" id="jumpArticleInput" placeholder="21" autofocus>
          </div>
          <div class="jump-quick-pills">
            <button class="jump-pill" data-num="14">14</button>
            <button class="jump-pill" data-num="19">19</button>
            <button class="jump-pill" data-num="21">21</button>
            <button class="jump-pill" data-num="21A">21A</button>
            <button class="jump-pill" data-num="32">32</button>
            <button class="jump-pill" data-num="51A">51A</button>
            <button class="jump-pill" data-num="226">226</button>
            <button class="jump-pill" data-num="368">368</button>
          </div>
          <div class="jump-actions">
            <button id="jumpCancelBtn" class="app-btn-secondary">Cancel</button>
            <button id="jumpGoBtn" class="app-btn-primary">Open Article</button>
          </div>
        </div>
      </div>

      <!-- Native Toast Container -->
      <div id="toastContainer" class="app-toast-container" aria-live="polite"></div>

    </div>
  </div>

  <!-- Supabase Cloud SDK -->
  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

  <!-- Complete Standalone Application Logic Bundle -->
  <script>
$combinedJs
  </script>
</body>
</html>
"@

[System.IO.File]::WriteAllText((Join-Path $base "index.html"), $finalHtml, [System.Text.Encoding]::UTF8)
Write-Host "Complete Standalone App Bundle successfully written to index.html!"
