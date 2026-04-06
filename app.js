const dictionary = [
  {
    polish: "Dzień dobry, jak się masz?",
    hindpol: "जेन दोब्री, याक शे माश",
    marpol: "ज्येन दोब्री, याक शें माश",
    hindi: "नमस्ते, आप कैसे हैं?",
    marathi: "नमस्कार, तुम्ही कसे आहात?",
    tense: "present",
    mapping: [
      { text: "नमस्ते", color: "action" },
      { text: "कैसे हैं", color: "noun" }
    ],
    tokens: [
      { text: "जेन दोब्री", color: "action" },
      { text: "याक शे माश", color: "noun" }
    ],
    words: [
      {
        polish: "dzień dobry",
        hindpol: "जेन दोब्री",
        hindi: ["नमस्ते"],
        marathi: ["नमस्कार"],
        pos: "वाक्यांश",
        memory: "सुबह दुकान में प्रवेश करते ही आप कहते हैं: dzień dobry।"
      }
    ]
  },
  {
    polish: "Rano idę do sklepu po chleb i mleko.",
    hindpol: "रानो इदे दो स्क्लेपू पो ख्लेब इ म्लेको",
    marpol: "रानो इदे दो स्क्लेपु पो ख्लेब इ म्लेको",
    hindi: "सुबह मैं ब्रेड और दूध लेने दुकान जाता/जाती हूं।",
    marathi: "सकाळी मी ब्रेड आणि दूध घ्यायला दुकानात जातो/जाते.",
    tense: "present",
    mapping: [
      { text: "सुबह मैं जाता/जाती हूं", color: "action" },
      { text: "ब्रेड और दूध", color: "noun" }
    ],
    tokens: [
      { text: "रानो इदे", color: "action" },
      { text: "दो स्क्लेपू", color: "action" },
      { text: "ख्लेब इ म्लेको", color: "noun" }
    ],
    words: [
      {
        polish: "sklep",
        hindpol: "स्क्लेप",
        hindi: ["दुकान"],
        marathi: ["दुकान"],
        pos: "संज्ञा",
        memory: "शॉपिंग बैग लेकर स्क्लेप जाते हुए याद करो: sklep।"
      }
    ]
  },
  {
    polish: "W kuchni gotuję zupę i kroję marchewkę.",
    hindpol: "व कुख्नी गोतुए जूपे इ क्रोये मार्चेव्के",
    marpol: "व कुख्नी गोतुये झुपें इ क्रोये मार्चेव्कें",
    hindi: "रसोई में मैं सूप बनाता/बनाती हूं और गाजर काटता/काटती हूं।",
    marathi: "स्वयंपाकघरात मी सूप बनवतो/बनवते आणि गाजर चिरतो/चिरते.",
    tense: "present",
    mapping: [
      { text: "मैं बनाता/बनाती हूं", color: "action" },
      { text: "सूप और गाजर", color: "noun" }
    ],
    tokens: [
      { text: "व कुख्नी", color: "noun" },
      { text: "गोतुए", color: "action" },
      { text: "जूपे इ मार्चेव्के", color: "noun" }
    ],
    words: [
      {
        polish: "kuchnia",
        hindpol: "कुख्न्या",
        hindi: ["रसोई"],
        marathi: ["स्वयंपाकघर"],
        pos: "संज्ञा",
        memory: "किचन में कुकर सीटी बजाए: kuchnia।"
      }
    ]
  },
  {
    polish: "Po południu pójdziemy do parku na spacer.",
    hindpol: "पो पवुदन्यू पुयेज़ेमी दो पार्कु ना स्पात्सेर",
    marpol: "पो पवुद्न्यू पुयेज़ेमी दो पार्कु ना स्पात्सेर",
    hindi: "दोपहर के बाद हम पार्क में टहलने जाएंगे।",
    marathi: "दुपारी आम्ही पार्कमध्ये फिरायला जाऊ.",
    tense: "future",
    mapping: [
      { text: "हम जाएंगे", color: "future" },
      { text: "पार्क में टहलना", color: "action" }
    ],
    tokens: [
      { text: "पुयेज़ेमी", color: "future" },
      { text: "दो पार्कु", color: "noun" },
      { text: "ना स्पात्सेर", color: "action" }
    ],
    words: [
      {
        polish: "spacer",
        hindpol: "स्पात्सेर",
        hindi: ["टहलना"],
        marathi: ["फिरणे"],
        pos: "संज्ञा",
        memory: "शाम को पार्क में स्पात्सेर करने चलना।"
      }
    ]
  },
  {
    polish: "Wieczorem pójdziemy do kina na nowy film.",
    hindpol: "विएचोरेम पुयेज़ेमी दो कीना ना नोवी फिल्म",
    marpol: "वियेचोरें पुयेज़ेमी दो कीना ना नोवी फिल्म",
    hindi: "शाम को हम नया फिल्म देखने सिनेमा जाएंगे।",
    marathi: "संध्याकाळी आम्ही नवीन चित्रपट पाहायला सिनेमाला जाऊ.",
    tense: "future",
    mapping: [
      { text: "हम जाएंगे", color: "future" },
      { text: "नया फिल्म", color: "noun" }
    ],
    tokens: [
      { text: "पुयेज़ेमी", color: "future" },
      { text: "दो कीना", color: "noun" },
      { text: "नोवी फिल्म", color: "noun" }
    ],
    words: [
      {
        polish: "kino",
        hindpol: "कीनो",
        hindi: ["सिनेमा"],
        marathi: ["सिनेमागृह"],
        pos: "संज्ञा",
        memory: "टिकट लेकर कीनो में फिल्म देखो।"
      }
    ]
  },
  {
    polish: "Wczoraj kupiłem świeże warzywa na targu.",
    hindpol: "व्चोराय कुपिवेम श्विएझे वाझिवा ना तार्गु",
    marpol: "व्चोराय कुपिवेम श्विएझे वार्जिवा ना तार्गु",
    hindi: "कल मैंने बाजार से ताजी सब्जियां खरीदीं।",
    marathi: "काल मी बाजारातून ताजी भाजी घेतली.",
    tense: "past",
    mapping: [
      { text: "मैंने खरीदा", color: "future" },
      { text: "ताजी सब्जियां", color: "noun" }
    ],
    tokens: [
      { text: "कुपिवेम", color: "future" },
      { text: "श्विएझे वाझिवा", color: "noun" }
    ],
    words: [
      {
        polish: "warzywa",
        hindpol: "वाझिवा",
        hindi: ["सब्जियां"],
        marathi: ["भाज्या"],
        pos: "संज्ञा",
        memory: "तराजू पर ताजी warzywa तौली जा रही हैं।"
      }
    ]
  },
  {
    polish: "Wczoraj spotkałem przyjaciela w parku.",
    hindpol: "व्चोराय स्पोत्कावेम प्शियाचेला व पार्कु",
    marpol: "व्चोराय स्पोत्कावेम प्शियाचेला व पार्कु",
    hindi: "कल मैं पार्क में अपने दोस्त से मिला।",
    marathi: "काल मी पार्कमध्ये माझ्या मित्राला भेटलो.",
    tense: "past",
    mapping: [
      { text: "मैं मिला", color: "future" },
      { text: "दोस्त", color: "noun" }
    ],
    tokens: [
      { text: "स्पोत्कावेम", color: "future" },
      { text: "प्शियाचेला", color: "noun" },
      { text: "व पार्कु", color: "action" }
    ],
    words: [
      {
        polish: "przyjaciel",
        hindpol: "प्शियाचेल",
        hindi: ["दोस्त"],
        marathi: ["मित्र"],
        pos: "संज्ञा",
        memory: "पुराना przyjaciel अचानक पार्क में मिल गया।"
      }
    ]
  },
  {
    polish: "Jutro będę gotować kolację dla rodziny.",
    hindpol: "युत्रो बेंदे गोतोवाच कोलात्से द्ला रोदज़िनी",
    marpol: "युत्रो बेंडे गोतोवाच कोलात्से द्ला रोड्जिनी",
    hindi: "कल मैं परिवार के लिए रात का खाना बनाऊंगा/बनाऊंगी।",
    marathi: "उद्या मी कुटुंबासाठी रात्रीचे जेवण बनवेन.",
    tense: "future",
    mapping: [
      { text: "मैं बनाऊंगा/बनाऊंगी", color: "future" },
      { text: "रात का खाना", color: "noun" }
    ],
    tokens: [
      { text: "बेंदे", color: "future" },
      { text: "गोतोवाच", color: "action" },
      { text: "कोलात्से", color: "noun" }
    ],
    words: [
      {
        polish: "kolacja",
        hindpol: "कोलात्स्या",
        hindi: ["रात का खाना"],
        marathi: ["रात्रीचे जेवण"],
        pos: "संज्ञा",
        memory: "रात की kolacja के लिए सब तैयारी हो रही है।"
      }
    ]
  },
  {
    polish: "Po zakupach wrócimy do domu autobusem.",
    hindpol: "पो ज़ाकूपाख व्रुत्सिमी दो दोमु आउतोबुसेम",
    marpol: "पो ज़ाकुपाख व्रुत्सिमी दो दोमु आउतोबुसेम",
    hindi: "खरीदारी के बाद हम बस से घर लौटेंगे।",
    marathi: "खरेदीनंतर आम्ही बसने घरी परतू.",
    tense: "future",
    mapping: [
      { text: "हम लौटेंगे", color: "future" },
      { text: "बस से घर", color: "noun" }
    ],
    tokens: [
      { text: "व्रुत्सिमी", color: "future" },
      { text: "दो दोमु", color: "noun" },
      { text: "आउतोबुसेम", color: "noun" }
    ],
    words: [
      {
        polish: "autobus",
        hindpol: "आउतोबुस",
        hindi: ["बस"],
        marathi: ["बस"],
        pos: "संज्ञा",
        memory: "autobus से शाम को घर वापसी का दृश्य याद रखें।"
      }
    ]
  },
  {
    polish: "Cześć, czy możesz mi pomóc w sklepie?",
    hindpol: "चेश्च, ची मुझेश मी पोमुत्स व स्क्लेप्ये",
    marpol: "चेश्च, ची मुझेश मी पोमुत्स व स्क्लेप्ये",
    hindi: "हाय, क्या आप दुकान में मेरी मदद कर सकते हैं?",
    marathi: "हाय, तुम्ही दुकानात मला मदत करू शकता का?",
    tense: "present",
    mapping: [
      { text: "क्या आप मदद कर सकते हैं", color: "action" },
      { text: "दुकान", color: "noun" }
    ],
    tokens: [
      { text: "ची मुझेश मी पोमुत्स", color: "action" },
      { text: "व स्क्लेप्ये", color: "noun" }
    ],
    words: [
      {
        polish: "pomóc",
        hindpol: "पोमुत्स",
        hindi: ["मदद करना"],
        marathi: ["मदत करणे"],
        pos: "क्रिया",
        memory: "जब मदद चाहिए हो तो बोलो: możesz mi pomóc?"
      }
    ]
  }
];

let extraWords = [
  ["robić", "रोबिच", "करना", "करणे", "क्रिया"],
  ["mówić", "मुविच", "बोलना", "बोलणे", "क्रिया"],
  ["iść", "इश्च", "जाना (पैदल)", "पायी जाणे", "क्रिया"],
  ["duży", "दुझी", "बड़ा", "मोठा", "विशेषण"],
  ["mały", "मावी", "छोटा", "लहान", "विशेषण"],
  ["noc", "नोत्स", "रात", "रात्र", "संज्ञा"],
  ["dzień", "जेन", "दिन", "दिवस", "संज्ञा"],
  ["dobry", "दोब्री", "अच्छा", "चांगला", "विशेषण"],
  ["szybko", "शिब्को", "जल्दी", "लवकर", "क्रिया-विशेषण"],
  ["człowiek", "च्वोव्येक", "इंसान", "माणूस", "संज्ञा"],
  ["mieć", "म्येच", "पास होना", "असणे", "क्रिया"],
  ["być", "बिच", "होना", "असणे", "क्रिया"]
];

const subtitleToggle = document.getElementById("subtitleToggle");
const pauseToggle = document.getElementById("pauseToggle");
const learningModeSelect = document.getElementById("learningModeSelect");
const wordCountBadge = document.getElementById("wordCountBadge");
const lineHindpol = document.getElementById("lineHindpol");
const linePolish = document.getElementById("linePolish");
const lineHindi = document.getElementById("lineHindi");
const semanticLegend = document.getElementById("semanticLegend");
const semanticTokens = document.getElementById("semanticTokens");
const wordGrid = document.getElementById("wordGrid");
const wordDetails = document.getElementById("wordDetails");
const pausePrompt = document.getElementById("pausePrompt");
const continueBtn = document.getElementById("continueBtn");
const nextLineBtn = document.getElementById("nextLine");
const playPolishBtn = document.getElementById("playPolish");
const tenseButtons = [...document.querySelectorAll(".tense-btn")];
const tabButtons = [...document.querySelectorAll(".tab-btn")];
const learningView = document.getElementById("learningView");
const dictionaryView = document.getElementById("dictionaryView");
const storyView = document.getElementById("storyView");
const arrowPastBtn = document.getElementById("arrowPast");
const arrowPresentBtn = document.getElementById("arrowPresent");
const arrowFutureBtn = document.getElementById("arrowFuture");
const showAllLanguagesToggle = document.getElementById("showAllLanguages");
const showPolishLineToggle = document.getElementById("showPolishLine");
const showPronLineToggle = document.getElementById("showPronLine");
const showMeaningLineToggle = document.getElementById("showMeaningLine");

const storyTitleInput = document.getElementById("storyTitle");
const storyLevelInput = document.getElementById("storyLevel");
const elevenApiKeyInput = document.getElementById("elevenApiKey");
const elevenVoiceIdInput = document.getElementById("elevenVoiceId");
const storyInput = document.getElementById("storyInput");
const buildStoryBtn = document.getElementById("buildStoryBtn");
const saveStoryBtn = document.getElementById("saveStoryBtn");
const storyLibrary = document.getElementById("storyLibrary");
const storyScenes = document.getElementById("storyScenes");
const storyBookHeading = document.getElementById("storyBookHeading");
const playStoryAudioBtn = document.getElementById("playStoryAudioBtn");
const stopStoryAudioBtn = document.getElementById("stopStoryAudioBtn");

let activeTense = "all";
let pool = [...dictionary];
let index = 0;
let learningMode = "indpol";
let currentBook = null;
const storyStorageKey = "indpol-story-books-v1";

function cls(color) {
  if (color === "future") return "color-future";
  if (color === "noun") return "color-noun";
  return "color-action";
}

function meaningLabel() {
  return learningMode === "marpol" ? "Marathi अर्थ" : "Hindi अर्थ";
}

function pickMeaning(item) {
  if (learningMode === "marpol") {
    return item.marathi || item.hindi;
  }
  return item.hindi;
}

function pickPronunciation(item) {
  if (learningMode === "marpol") {
    return item.marpol || item.hindpol;
  }
  return item.hindpol;
}

function pickMeaningList(item) {
  if (learningMode === "marpol") {
    return item.marathi || item.hindi || [];
  }
  return item.hindi || [];
}

function updateWordCountBadge() {
  const set = new Set();
  dictionary.forEach((d) => d.words.forEach((w) => set.add(w.polish)));
  extraWords.forEach(([polish]) => set.add(polish));
  wordCountBadge.textContent = `Polish words: ${set.size}`;
}

function renderTokenHighlights(item) {
  if (Array.isArray(item.tokens) && item.tokens.length) {
    return item.tokens
      .map((t) => `<span class="token ${cls(t.color)}">${t.text}</span>`)
      .join(" ");
  }

  const pronunciation = pickPronunciation(item);
  return `<span class="token ${cls("action")}">${pronunciation}</span>`;
}

function buildPolishChunks(polishText, chunkCount) {
  const text = String(polishText || "").trim();
  if (!text) return [];

  if (chunkCount === 2 && text.includes(",")) {
    const pair = text.split(",").map((v) => v.trim()).filter(Boolean);
    if (pair.length === 2) return [pair[0], pair[1]];
  }

  const words = text.split(/\s+/).filter(Boolean);
  if (!chunkCount || chunkCount <= 1 || words.length <= 1) {
    return [text];
  }

  const groups = [];
  let cursor = 0;
  for (let i = 0; i < chunkCount; i++) {
    const remainingWords = words.length - cursor;
    const remainingGroups = chunkCount - i;
    const take = Math.ceil(remainingWords / remainingGroups);
    const part = words.slice(cursor, cursor + take).join(" ");
    if (part) groups.push(part);
    cursor += take;
  }
  return groups.length ? groups : [text];
}

function renderPolishHighlights(polishText, tokens) {
  const chunkCount = Array.isArray(tokens) ? tokens.length : 0;
  const chunks = buildPolishChunks(polishText, chunkCount);

  return chunks
    .map((chunk, idx) => {
      const color = tokens?.[idx]?.color || "action";
      return `<span class="token ${cls(color)}">${chunk}</span>`;
    })
    .join(" ");
}

function renderMeaningHighlights(item) {
  if (Array.isArray(item.mapping) && item.mapping.length) {
    return item.mapping
      .map((m) => `<span class="token meaning-token ${cls(m.color)}">${m.text}</span>`)
      .join(" ");
  }

  return `<span class="token meaning-token ${cls("action")}">${pickMeaning(item)}</span>`;
}

function applyLineVisibility() {
  const polishOn = !!(showPolishLineToggle?.checked);
  const pronOn = !!(showPronLineToggle?.checked);
  const meaningOn = !!(showMeaningLineToggle?.checked);

  linePolish.classList.toggle("hidden", !polishOn);
  lineHindpol.classList.toggle("hidden", !pronOn);
  lineHindi.classList.toggle("hidden", !meaningOn);

  if (showAllLanguagesToggle) {
    showAllLanguagesToggle.checked = polishOn && pronOn && meaningOn;
  }
}

function renderLine() {
  if (!pool.length) {
    lineHindpol.textContent = "कोई पंक्ति उपलब्ध नहीं";
    linePolish.textContent = "Brak";
    lineHindi.textContent = "डेटा नहीं";
    semanticLegend.innerHTML = "";
    semanticTokens.innerHTML = "";
    return;
  }

  const item = pool[index % pool.length];
  lineHindpol.innerHTML = renderTokenHighlights(item);
  linePolish.innerHTML = renderPolishHighlights(item.polish, item.tokens);
  lineHindi.innerHTML = renderMeaningHighlights(item);

  semanticLegend.innerHTML = item.mapping
    .map((m) => `<span class="badge ${cls(m.color)}">${m.text}</span>`)
    .join("");

  semanticTokens.innerHTML = item.tokens
    .map((t) => `<span class="token ${cls(t.color)}">${t.text}</span>`)
    .join("");

  if (pauseToggle.checked) {
    pausePrompt.classList.remove("hidden");
    nextLineBtn.disabled = true;
  } else {
    pausePrompt.classList.add("hidden");
    nextLineBtn.disabled = false;
  }

  if (!subtitleToggle.checked) {
    lineHindpol.classList.add("hidden");
    lineHindi.classList.add("hidden");
  } else {
    applyLineVisibility();
  }
}

function nextLine() {
  index = (index + 1) % Math.max(pool.length, 1);
  renderLine();
}

function setTense(tense) {
  activeTense = tense;
  pool = tense === "all" ? [...dictionary] : dictionary.filter((d) => d.tense === tense);
  index = 0;
  tenseButtons.forEach((b) => b.classList.toggle("active", b.dataset.tense === tense));
  if (arrowPastBtn && arrowPresentBtn && arrowFutureBtn) {
    arrowPastBtn.classList.toggle("active", tense === "past");
    arrowPresentBtn.classList.toggle("active", tense === "present" || tense === "all");
    arrowFutureBtn.classList.toggle("active", tense === "future");
  }
  renderLine();
}

function buildWordPanel() {
  const baseWords = dictionary.flatMap((d) => d.words);
  const map = new Map();

  baseWords.forEach((w) => {
    if (!map.has(w.polish)) {
      map.set(w.polish, w);
    }
  });

  extraWords.forEach(([polish, hindpol, hindi, marathi, pos, marpol]) => {
    if (!map.has(polish)) {
      map.set(polish, {
        polish,
        hindpol,
        marpol,
        hindi: Array.isArray(hindi) ? hindi : [hindi],
        marathi: Array.isArray(marathi) ? marathi : [marathi],
        pos,
        memory: "इस शब्द के लिए कस्टम memory scene जोड़ना बाकी है।"
      });
    }
  });

  const list = [...map.values()]
    .sort((a, b) => a.polish.localeCompare(b.polish, "pl", { sensitivity: "base" }));
  if (document.getElementById('dictCount')) {
    document.getElementById('dictCount').textContent = `(${list.length} Words)`;
  }

  wordGrid.innerHTML = list
    .map(
      (w, idx) =>
        `<button class="word-pill" data-word-index="${idx}">` +
        `<strong>${w.polish}</strong>` +
        `<span class="small">${pickPronunciation(w)} • ${pickMeaningList(w)[0] || "-"}</span>` +
        `</button>`
    )
    .join("");

  wordGrid.querySelectorAll(".word-pill").forEach((btn) => {
    btn.addEventListener("click", () => {
      const w = list[Number(btn.dataset.wordIndex)];
      wordDetails.classList.remove("muted");
      const pronLabel = learningMode === "marpol" ? "Marpol" : "Indpol";
      wordDetails.innerHTML =
        `<div class="pol">${w.polish}</div>` +
        `<div><strong>${pronLabel}:</strong> ${pickPronunciation(w)}</div>` +
        `<div><strong>${meaningLabel()}:</strong> ${pickMeaningList(w).join(" / ")}</div>` +
        `<div><strong>Part of Speech:</strong> ${w.pos}</div>` +
        `<div><strong>Memory:</strong> ${w.memory}</div>`;
    });
  });
}

function playPolishAudio() {
  const item = pool[index % pool.length];
  if (!item) return;

  if (!("speechSynthesis" in window)) {
    alert("इस ब्राउजर में आवाज सुविधा उपलब्ध नहीं है।");
    return;
  }

  const utter = new SpeechSynthesisUtterance(item.polish);
  utter.lang = "pl-PL";
  utter.rate = 0.85;
  window.speechSynthesis.cancel();
  window.speechSynthesis.speak(utter);
}

function switchTab(target) {
  const isLearning = target === "learning";
  const isDictionary = target === "dictionary";
  const isStory = target === "story";

  learningView.classList.toggle("hidden", !isLearning);
  dictionaryView.classList.toggle("hidden", !isDictionary);
  storyView.classList.toggle("hidden", !isStory);

  tabButtons.forEach((btn) => {
    const active = btn.dataset.tab === target;
    btn.classList.toggle("active", active);
    btn.setAttribute("aria-selected", String(active));
  });
}

function setLearningMode(mode) {
  learningMode = mode === "marpol" ? "marpol" : "indpol";
  if (learningModeSelect.value !== learningMode) {
    learningModeSelect.value = learningMode;
  }
  buildWordPanel();
  renderLine();
  if (currentBook) {
    renderStoryBook(currentBook);
  }
}

function parseStoryInput(raw) {
  const clean = raw.trim();
  if (!clean) return [];

  return clean
    .split(/\n\s*\n+/)
    .map((block) => block.split("\n").map((v) => v.trim()).filter(Boolean))
    .filter((lines) => lines.length > 0)
    .map((lines, idx) => {
      if (lines.length >= 3) {
        const meaningLine = lines[2];
        return {
          idx: idx + 1,
          hindpol: lines[0],
          polish: lines[1],
          hindi: learningMode === "marpol" ? "हिंदी अर्थ जोड़ें" : meaningLine,
          marathi: learningMode === "marpol" ? meaningLine : "मराठी अर्थ जोड़ें"
        };
      }

      const polish = lines[0];
      const fallbackMeaning = lines[1] || "अर्थ जोड़ें";
      return {
        idx: idx + 1,
        hindpol: polishToHindpol(polish),
        polish,
        hindi: learningMode === "marpol" ? "हिंदी अर्थ जोड़ें" : fallbackMeaning,
        marathi: learningMode === "marpol" ? fallbackMeaning : "मराठी अर्थ जोड़ें"
      };
    })
    .map((scene) => ({
      ...scene,
      tense: detectTense(scene.polish),
      imageUrl: sceneImageUrl(scene.polish),
      audioUrl: ""
    }));
}

function polishToHindpol(polishText) {
  const rulePairs = [
    ["dzi", "जी"],
    ["sz", "श"],
    ["cz", "च"],
    ["rz", "झ"],
    ["ś", "श"],
    ["ć", "च"],
    ["ł", "व"],
    ["ż", "झ"],
    ["ą", "ओं"],
    ["ę", "एं"],
    ["j", "य"],
    ["w", "व"]
  ];

  let out = polishText.toLowerCase();
  rulePairs.forEach(([src, tgt]) => {
    out = out.split(src).join(tgt);
  });
  out = out
    .replace(/ch/g, "ख")
    .replace(/h/g, "ह")
    .replace(/c/g, "त्स");

  return out;
}

function detectTense(polishLine) {
  const p = polishLine.toLowerCase();
  if (p.includes("będ") || p.includes("bed")) return "future";
  if (p.endsWith("łem") || p.endsWith("łam") || p.includes("był") || p.includes("miał")) return "past";
  return "present";
}

function tenseArrow(tense) {
  if (tense === "future") return "➡️➡️ भविष्य";
  if (tense === "past") return "⬅️ भूतकाल";
  return "➡️ वर्तमान";
}

function sceneImageUrl(polishText) {
  const prompt = `storybook illustration, polish language learning, ${polishText}`;
  return `https://image.pollinations.ai/prompt/${encodeURIComponent(prompt)}`;
}

function buildStoryBookFromInput() {
  const title = storyTitleInput.value.trim() || "Untitled Story";
  const level = storyLevelInput.value;
  const scenes = parseStoryInput(storyInput.value);

  if (!scenes.length) {
    alert("पहले story input डालें।");
    return;
  }

  currentBook = {
    id: `book-${Date.now()}`,
    title,
    level,
    mode: learningMode,
    createdAt: new Date().toISOString(),
    scenes
  };
  renderStoryBook(currentBook);
}

function renderStoryBook(book) {
  storyBookHeading.textContent = `${book.title} (${book.level})`;

  storyScenes.innerHTML = book.scenes
    .map((scene) => {
      const meaningLine = learningMode === "marpol"
        ? (scene.marathi || scene.hindi || "")
        : (scene.hindi || scene.marathi || "");
      const tokens = scene.hindpol.split(" ").filter(Boolean);
      const mappedTokens = tokens
        .map((token, i) => {
          const color = i === 0 ? "future" : i === tokens.length - 1 ? "noun" : "action";
          return `<span class="token ${cls(color)}">${token}</span>`;
        })
        .join("");

      return (
        `<article class="scene">` +
        `<div class="scene-img-wrap"><img class="scene-img" src="${scene.imageUrl}" alt="scene ${scene.idx}" loading="lazy" /></div>` +
        `<div class="scene-body">` +
        `<div class="scene-header"><strong>Scene ${scene.idx}</strong><span class="scene-arrow">${tenseArrow(scene.tense)}</span></div>` +
        `<p class="line hindpol">${scene.hindpol}</p>` +
        `<p class="line polish">${scene.polish}</p>` +
        `<p class="line hindi">${meaningLine}</p>` +
        `<div class="tokens">${mappedTokens}</div>` +
        `<audio class="scene-audio" controls src="${scene.audioUrl || ""}"></audio>` +
        `</div></article>`
      );
    })
    .join("");
}

function loadBooks() {
  try {
    return JSON.parse(localStorage.getItem(storyStorageKey) || "[]");
  } catch {
    return [];
  }
}

function saveBooks(list) {
  localStorage.setItem(storyStorageKey, JSON.stringify(list));
}

function saveCurrentBook() {
  if (!currentBook) {
    alert("पहले Story Book बनाएं, फिर save करें।");
    return;
  }

  const books = loadBooks();
  books.unshift({ ...currentBook, mode: learningMode });
  saveBooks(books);
  renderStoryLibrary();
}

function renderStoryLibrary() {
  const books = loadBooks();
  if (!books.length) {
    storyLibrary.innerHTML = `<div class="muted">अभी तक कोई story book save नहीं हुई है।</div>`;
    return;
  }

  storyLibrary.innerHTML = books
    .map((b, idx) => {
      const date = new Date(b.createdAt).toLocaleDateString("hi-IN");
      return (
        `<article class="book-card">` +
        `<strong>${b.title}</strong>` +
        `<div class="book-meta">Level: ${b.level} • Scenes: ${b.scenes.length}</div>` +
        `<div class="book-meta">Saved: ${date}</div>` +
        `<div class="btn-row"><button class="btn" data-open-book="${idx}">Open</button></div>` +
        `</article>`
      );
    })
    .join("");

  storyLibrary.querySelectorAll("[data-open-book]").forEach((btn) => {
    btn.addEventListener("click", () => {
      const booksList = loadBooks();
      const book = booksList[Number(btn.dataset.openBook)];
      if (!book) return;
      setLearningMode(book.mode || learningMode);
      currentBook = book;
      renderStoryBook(book);
    });
  });
}

async function generateElevenLabsAudioForStory() {
  if (!currentBook) {
    alert("पहले story बनाएं या library से open करें।");
    return;
  }

  const apiKey = elevenApiKeyInput.value.trim();
  const voiceId = elevenVoiceIdInput.value.trim();

  if (!apiKey || !voiceId) {
    alert("11Labs API key और voice id भरें।");
    return;
  }

  playStoryAudioBtn.disabled = true;
  playStoryAudioBtn.textContent = "Audio बन रहा है...";

  try {
    const updatedScenes = [];

    for (const scene of currentBook.scenes) {
      const response = await fetch(`https://api.elevenlabs.io/v1/text-to-speech/${voiceId}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "xi-api-key": apiKey
        },
        body: JSON.stringify({
          text: scene.polish,
          model_id: "eleven_multilingual_v2",
          voice_settings: {
            stability: 0.45,
            similarity_boost: 0.85
          }
        })
      });

      if (!response.ok) {
        throw new Error(`11Labs error: ${response.status}`);
      }

      const audioBlob = await response.blob();
      const audioUrl = URL.createObjectURL(audioBlob);
      updatedScenes.push({ ...scene, audioUrl });
    }

    currentBook = { ...currentBook, scenes: updatedScenes };
    renderStoryBook(currentBook);
  } catch (error) {
    alert(`Audio generation असफल रहा: ${error.message}`);
  } finally {
    playStoryAudioBtn.disabled = false;
    playStoryAudioBtn.textContent = "11Labs Audio";
  }
}

function stopStoryAudio() {
  storyScenes.querySelectorAll("audio").forEach((el) => {
    el.pause();
    el.currentTime = 0;
  });
}

subtitleToggle.addEventListener("change", renderLine);
pauseToggle.addEventListener("change", renderLine);
learningModeSelect.addEventListener("change", (e) => setLearningMode(e.target.value));
if (showAllLanguagesToggle && showPolishLineToggle && showPronLineToggle && showMeaningLineToggle) {
  showAllLanguagesToggle.addEventListener("change", () => {
    const on = showAllLanguagesToggle.checked;
    showPolishLineToggle.checked = on;
    showPronLineToggle.checked = on;
    showMeaningLineToggle.checked = on;
    renderLine();
  });

  [showPolishLineToggle, showPronLineToggle, showMeaningLineToggle].forEach((el) => {
    el.addEventListener("change", () => {
      applyLineVisibility();
      renderLine();
    });
  });
}
continueBtn.addEventListener("click", () => {
  nextLineBtn.disabled = false;
  nextLine();
});
nextLineBtn.addEventListener("click", nextLine);
playPolishBtn.addEventListener("click", playPolishAudio);
tenseButtons.forEach((btn) => btn.addEventListener("click", () => setTense(btn.dataset.tense)));
if (arrowPastBtn) arrowPastBtn.addEventListener("click", () => setTense("past"));
if (arrowPresentBtn) arrowPresentBtn.addEventListener("click", () => setTense("present"));
if (arrowFutureBtn) arrowFutureBtn.addEventListener("click", () => setTense("future"));
tabButtons.forEach((btn) => btn.addEventListener("click", () => switchTab(btn.dataset.tab)));
buildStoryBtn.addEventListener("click", buildStoryBookFromInput);
saveStoryBtn.addEventListener("click", saveCurrentBook);
playStoryAudioBtn.addEventListener("click", generateElevenLabsAudioForStory);
stopStoryAudioBtn.addEventListener("click", stopStoryAudio);

// Load database and initialize
async function loadPolishLexicon() {
  try {
    const hindiRes = await fetch('data/indpol_baza/indpol_hindi_words.json');
    const marathiRes = await fetch('data/indpol_baza/indpol_marathi_words.json');

    if (hindiRes.ok && marathiRes.ok) {
      const hindiDb = await hindiRes.json();
      const marathiDb = await marathiRes.json();

      const marathiMap = new Map();
      const marathiPronMap = new Map();
      marathiDb.data.forEach((w) => {
        marathiMap.set(w.polish, w.marathi_meaning || "[अर्थ प्रलंबित]");
        marathiPronMap.set(w.polish, w.marpol || w.indpol || "");
      });

      extraWords = hindiDb.data.map((w) => [
        w.polish,
        w.indpol,
        w.hindi_meaning,
        marathiMap.get(w.polish) || "[अर्थ प्रलंबित]",
        w.pos || 'noun',
        marathiPronMap.get(w.polish) || w.indpol
      ]);

      console.log(`✓ Loaded ${extraWords.length} words from Indpol Hindi+Marathi databases`);
      return true;
    }

    const response = await fetch('data/polish_lexicon.json');
    const db = await response.json();

    extraWords = db.words.map((w) => [
      w.polish,
      w.hindpol,
      w.hindi,
      w.marathi,
      w.pos || 'noun'
    ]);

    console.log(`✓ Loaded ${extraWords.length} words from fallback database`);
    return true;
  } catch (error) {
    console.warn('⚠ Could not load database, using hardcoded data:', error.message);
    return false;
  }
}

// Initialize app
(async function() {
  await loadPolishLexicon();
  buildWordPanel();
  updateWordCountBadge();
  renderStoryLibrary();
  setLearningMode(learningModeSelect.value);
})();
