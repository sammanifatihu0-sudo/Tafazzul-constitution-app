$base = $PSScriptRoot
$utf8 = [System.Text.Encoding]::UTF8

# Read CSS
$cssBytes = [System.IO.File]::ReadAllBytes((Join-Path $base "css\style.css"))
$css = $utf8.GetString($cssBytes)

# Read JS Files
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
foreach ($f in $jsFiles) {
  $fPath = Join-Path $base $f
  if (Test-Path $fPath) {
    $bytes = [System.IO.File]::ReadAllBytes($fPath)
    $combinedJs += "`n// --- $f ---`n" + $utf8.GetString($bytes) + "`n"
  }
}

# Add Splash Screen Auto-Dismiss Logic
$splashJs = @'
// --- Splash Screen Controller ---
(function() {
  function dismissSplash() {
    const splash = document.getElementById("appSplashScreen");
    if (splash && !splash.classList.contains("hidden")) {
      splash.classList.add("hidden");
      setTimeout(() => {
        splash.style.display = "none";
      }, 700);
    }
  }

  // Auto-dismiss after smooth 2-second grand intro
  window.addEventListener("load", () => {
    setTimeout(dismissSplash, 1800);
  });

  // Fallback tap-to-skip
  document.addEventListener("DOMContentLoaded", () => {
    const splash = document.getElementById("appSplashScreen");
    if (splash) {
      splash.addEventListener("click", dismissSplash);
    }
    setTimeout(dismissSplash, 2500);
  });
})();
'@

$combinedJs += "`n" + $splashJs + "`n"

# Rich Authentic Constitution App with TAFAZZUL Grand Splash Screen
$html = @'
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
  <meta name="theme-color" content="#0b1120">
  <link rel="manifest" href="manifest.json">

  <!-- Typography -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=Merriweather:ital,wght@0,300;0,400;0,700;1,300&family=Noto+Sans+Devanagari:wght@400;600;700&display=swap" rel="stylesheet">
  
  <!-- Embedded High-Performance Stylesheet -->
  <style>
/*__CSS__*/

/* === MAJESTIC CONSTITUTION BACKGROUND & LUXURY THEME === */
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  min-height: 100%;
  background-color: #0b1120;
  background-image: 
    radial-gradient(circle at 50% 0%, rgba(217, 119, 6, 0.15), transparent 40%),
    radial-gradient(circle at 10% 90%, rgba(5, 150, 105, 0.12), transparent 40%),
    radial-gradient(circle at 90% 90%, rgba(37, 99, 235, 0.12), transparent 40%);
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
  background-image: 
    radial-gradient(circle at 50% 12%, rgba(217, 119, 6, 0.05) 0%, transparent 60%),
    radial-gradient(circle at 90% 85%, rgba(5, 150, 105, 0.04) 0%, transparent 50%),
    url("data:image/svg+xml,%3Csvg width='160' height='160' viewBox='0 0 160 160' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' stroke='%23d97706' stroke-width='0.75' stroke-opacity='0.04'%3E%3Ccircle cx='80' cy='80' r='60'/%3E%3Ccircle cx='80' cy='80' r='40'/%3E%3Ccircle cx='80' cy='80' r='20'/%3E%3Cline x1='80' y1='20' x2='80' y2='140'/%3E%3Cline x1='20' y1='80' x2='140' y2='80'/%3E%3Cline x1='37.57' y1='37.57' x2='122.43' y2='122.43'/%3E%3Cline x1='37.57' y1='122.43' x2='122.43' y2='37.57'/%3E%3C/g%3E%3C/svg%3E");
  background-repeat: repeat;
  position: relative;
  overflow: hidden;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25), 0 0 0 1px rgba(217, 119, 6, 0.15);
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
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
}

.app-viewport {
  flex: 1;
  overflow-y: auto;
  padding: 1rem;
  padding-bottom: 5.5rem;
  -webkit-overflow-scrolling: touch;
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
  box-shadow: 0 -4px 15px rgba(0,0,0,0.04);
}

/* Luxury Hero Card */
.app-hero-card {
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.96)),
              radial-gradient(circle at 100% 0%, rgba(217, 119, 6, 0.14), transparent 70%);
  border: 1.5px solid rgba(217, 119, 6, 0.3);
  border-radius: var(--radius-lg);
  padding: 1.25rem;
  margin-bottom: 1.25rem;
  box-shadow: 0 4px 20px -2px rgba(217, 119, 6, 0.09);
  position: relative;
  overflow: hidden;
}

.app-hero-card::after {
  content: '';
  position: absolute;
  top: -15px;
  right: -15px;
  width: 90px;
  height: 90px;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 24 24' fill='none' stroke='%23d97706' stroke-width='1' stroke-opacity='0.22' xmlns='http://www.w3.org/2000/svg'%3E%3Ccircle cx='12' cy='12' r='10'/%3E%3Cpath d='M12 2v20M2 12h20M4.93 4.93l14.14 14.14M4.93 19.07L19.07 4.93'/%3E%3C/svg%3E");
  background-size: contain;
  background-repeat: no-repeat;
  pointer-events: none;
}

[data-theme="dark"] .app-hero-card {
  background: linear-gradient(135deg, #1e293b, #0f172a);
  border-color: rgba(217, 119, 6, 0.35);
}

/* === REALISTIC 3D GRADIENT ICON BADGES === */
.app-grid-icon {
  width: 44px !important;
  height: 44px !important;
  border-radius: 12px !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  flex-shrink: 0 !important;
  transition: all 0.2s cubic-bezier(0.34, 1.56, 0.64, 1) !important;
  border: none !important;
}

.app-grid-card:hover .app-grid-icon,
.app-grid-card:active .app-grid-icon {
  transform: scale(1.1) rotate(2deg) !important;
}

.icon-preamble {
  background: linear-gradient(135deg, #f59e0b, #d97706) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(217, 119, 6, 0.4) !important;
}

.icon-rights {
  background: linear-gradient(135deg, #3b82f6, #1d4ed8) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(37, 99, 235, 0.4) !important;
}

.icon-duties {
  background: linear-gradient(135deg, #fbbf24, #d97706) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(245, 158, 11, 0.4) !important;
}

.icon-dpsp {
  background: linear-gradient(135deg, #10b981, #047857) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(5, 150, 105, 0.4) !important;
}

.icon-parts {
  background: linear-gradient(135deg, #818cf8, #4338ca) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(79, 70, 229, 0.4) !important;
}

.icon-schedules {
  background: linear-gradient(135deg, #0ea5e9, #0369a1) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(2, 132, 199, 0.4) !important;
}

.icon-amendments {
  background: linear-gradient(135deg, #f43f5e, #be123c) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(225, 29, 72, 0.4) !important;
}

.icon-saved {
  background: linear-gradient(135deg, #ec4899, #be185d) !important;
  color: #ffffff !important;
  box-shadow: 0 4px 14px rgba(219, 39, 119, 0.4) !important;
}

/* === ULTRA-PREMIUM TAFAZZUL SPLASH SCREEN === */
.app-splash-screen {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(180deg, #090d16 0%, #0f172a 50%, #080c14 100%);
  z-index: 99999;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  padding: 3.5rem 1.5rem 2rem 1.5rem;
  box-sizing: border-box;
  opacity: 1;
  visibility: visible;
  transition: opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1), transform 0.6s cubic-bezier(0.4, 0, 0.2, 1), visibility 0.6s;
}

.app-splash-screen.hidden {
  opacity: 0;
  visibility: hidden;
  transform: scale(1.05);
  pointer-events: none;
}

.splash-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-top: auto;
  margin-bottom: auto;
}

.splash-logo-wrap {
  position: relative;
  width: 90px;
  height: 90px;
  margin-bottom: 1.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.splash-glow {
  position: absolute;
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(217, 119, 6, 0.45) 0%, rgba(217, 119, 6, 0) 70%);
  animation: splashPulse 2s infinite ease-in-out;
}

.splash-badge {
  position: relative;
  width: 80px;
  height: 80px;
  border-radius: 22px;
  background: linear-gradient(135deg, #d97706 0%, #92400e 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 25px rgba(217, 119, 6, 0.4), inset 0 1px 1px rgba(255, 255, 255, 0.4);
  border: 1px solid rgba(251, 191, 36, 0.5);
  animation: splashScaleIn 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.splash-brand-title {
  font-size: 2.25rem;
  font-weight: 900;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  margin: 0;
  background: linear-gradient(135deg, #ffffff 0%, #fef3c7 50%, #f59e0b 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 0 4px 20px rgba(217, 119, 6, 0.3);
  animation: splashFadeUp 0.9s ease-out 0.2s both;
}

.splash-brand-sub {
  font-size: 0.9375rem;
  font-weight: 700;
  color: #e2e8f0;
  margin-top: 0.4rem;
  letter-spacing: 0.05em;
  animation: splashFadeUp 0.9s ease-out 0.3s both;
}

.splash-brand-tag {
  font-size: 0.75rem;
  font-weight: 500;
  color: #94a3b8;
  margin-top: 0.25rem;
  letter-spacing: 0.02em;
  animation: splashFadeUp 0.9s ease-out 0.4s both;
}

.splash-loader-bar {
  width: 140px;
  height: 3px;
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.12);
  margin-top: 2rem;
  overflow: hidden;
  position: relative;
  animation: splashFadeUp 0.9s ease-out 0.5s both;
}

.splash-loader-progress {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 0%;
  background: linear-gradient(90deg, #f59e0b, #fbbf24);
  border-radius: 9999px;
  animation: splashProgress 1.6s cubic-bezier(0.65, 0, 0.35, 1) forwards;
}

.splash-footer {
  font-size: 0.6875rem;
  color: #64748b;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  animation: splashFadeUp 0.9s ease-out 0.6s both;
}

@keyframes splashPulse {
  0%, 100% { transform: scale(1); opacity: 0.6; }
  50% { transform: scale(1.25); opacity: 0.9; }
}

@keyframes splashScaleIn {
  from { transform: scale(0.6); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}

@keyframes splashFadeUp {
  from { transform: translateY(12px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

@keyframes splashProgress {
  0% { width: 0%; }
  50% { width: 65%; }
  100% { width: 100%; }
}

.sheet-item-icon svg {
  display: block;
}
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
      
      <!-- GRAND TAFAZZUL APP INTRO SPLASH SCREEN -->
      <div id="appSplashScreen" class="app-splash-screen" title="Tap to enter app">
        <div class="splash-content">
          <div class="splash-logo-wrap">
            <div class="splash-glow"></div>
            <div class="splash-badge">
              <svg width="46" height="46" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
                <path d="M2 17l10 5 10-5"></path>
                <path d="M2 12l10 5 10-5"></path>
              </svg>
            </div>
          </div>
          <h1 class="splash-brand-title">TAFAZZUL</h1>
          <div class="splash-brand-sub">Constitution of India</div>
          <div class="splash-brand-tag">The Supreme Legal Reference App</div>
          
          <div class="splash-loader-bar">
            <div class="splash-loader-progress"></div>
          </div>
        </div>
        <div class="splash-footer">
          <span>Official Reference &#8226; Version 1.0</span>
        </div>
      </div>

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
            <div class="app-logo-badge" style="background: linear-gradient(135deg, #d97706, #b45309); color: #fff;">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
                <path d="M2 17l10 5 10-5"></path>
                <path d="M2 12l10 5 10-5"></path>
              </svg>
            </div>
            <div class="topbar-title-wrap">
              <h1 class="topbar-title" id="topbarTitle" style="font-weight: 800; letter-spacing: -0.01em;">TAFAZZUL Constitution</h1>
              <span class="topbar-subtitle" id="topbarSubtitle" style="color: var(--accent-amber); font-weight: 600;">India &#8226; Official App</span>
            </div>
          </div>
        </div>

        <div class="topbar-right">
          <!-- Professional Compass / Direct Article Jump Button -->
          <button id="jumpPadBtn" class="topbar-icon-btn" title="Quick Article Jump" aria-label="Jump to Article Number">
            <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"></circle>
              <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" fill="currentColor"></polygon>
            </svg>
          </button>

          <!-- Language Selector Button -->
          <button id="langModalTriggerBtn" class="topbar-icon-btn lang-pill-btn" title="Change Language" aria-label="Change Language">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 3px;"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
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
            <h3 class="jump-title" style="margin-bottom: 0; display: flex; align-items: center; gap: 0.4rem;">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
              Choose Language
            </h3>
            <button id="closeLangModalBtn" style="font-size: 1.5rem; line-height: 1; color: var(--text-muted);">&times;</button>
          </div>
          <p class="jump-desc">Select your preferred language for reading the Constitution:</p>
          
          <div class="language-picker-grid" id="langListContainer" style="overflow-y: auto; flex: 1; margin-bottom: 1rem; max-height: 320px; display: flex; flex-direction: column; gap: 0.4rem;">
            <!-- Language items populated dynamically -->
          </div>

          <div style="text-align: right;">
            <button id="langModalDoneBtn" class="app-btn-primary" style="width: 100%;">Apply Language</button>
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
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#d97706" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetPreambleTitle">The Preamble</span>
                <span class="sheet-item-desc">Sovereign, Socialist, Secular Republic values</span>
              </div>
            </a>
            <a href="#schedules" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetSchedulesTitle">Schedules (1 to 12)</span>
                <span class="sheet-item-desc">Official languages, powers, and oaths</span>
              </div>
            </a>
            <a href="#fundamental-duties" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#d97706" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetDutiesTitle">Fundamental Duties (51A)</span>
                <span class="sheet-item-desc">11 Civic duties of citizens</span>
              </div>
            </a>
            <a href="#dpsp" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#059669" stroke-width="2"><rect x="4" y="4" width="16" height="16" rx="2"></rect><line x1="9" y1="9" x2="9" y2="15"></line><line x1="15" y1="9" x2="15" y2="15"></line></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetDpspTitle">Directive Principles (DPSP)</span>
                <span class="sheet-item-desc">Part IV state welfare policies</span>
              </div>
            </a>
            <a href="#amendments" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#e11d48" stroke-width="2"><path d="M12 3v18"></path><path d="M3 7l9-4 9 4"></path><path d="M6 10l-3 6h6l-3-6z"></path><path d="M18 10l-3 6h6l-3-6z"></path></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title" id="sheetAmendmentsTitle">Constitutional Amendments</span>
                <span class="sheet-item-desc">From 1st to 106th Amendment</span>
              </div>
            </a>
            <a href="#recent" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title">Recently Viewed</span>
                <span class="sheet-item-desc">Your reading history</span>
              </div>
            </a>
            <a href="#data-manager" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><polyline points="23 4 23 10 17 10"></polyline><polyline points="1 20 1 14 7 14"></polyline><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path></svg>
              </span>
              <div class="sheet-item-text">
                <span class="sheet-item-title">Data Management & Import</span>
                <span class="sheet-item-desc">Update official constitutional data</span>
              </div>
            </a>
            <a href="#about" class="sheet-item">
              <span class="sheet-item-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0f172a" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
              </span>
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
/*__JS__*/
  </script>
</body>
</html>
'@

$final = $html.Replace('/*__CSS__*/', $css).Replace('/*__JS__*/', $combinedJs)
$finalBytes = $utf8.GetBytes($final)
[System.IO.File]::WriteAllBytes((Join-Path $base "index.html"), $finalBytes)
Write-Host "Grand TAFAZZUL Splash Screen Integrated Successfully!"
