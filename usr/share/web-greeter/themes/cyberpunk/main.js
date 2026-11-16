function updateClock() {
  const now = new Date();
  document.getElementById("clock").textContent = now.toLocaleTimeString("es-MX", { hour12: false });
}
setInterval(updateClock, 1000);
updateClock();

const canvas = document.getElementById("cyber-canvas");
const ctx = canvas.getContext("2d");
let w = (canvas.width = window.innerWidth);
let h = (canvas.height = window.innerHeight);
const chars = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉ0123456789ABCDEF";
const fontSize = 15;
let columns = Math.floor(w / fontSize);
let drops = Array(columns).fill(1);

window.addEventListener("resize", () => {
  w = canvas.width = window.innerWidth;
  h = canvas.height = window.innerHeight;
  columns = Math.floor(w / fontSize);
  drops = Array(columns).fill(1);
});

setInterval(() => {
  ctx.fillStyle = "rgba(11, 14, 20, 0.08)";
  ctx.fillRect(0, 0, w, h);
  ctx.font = fontSize + "px JetBrainsMono Nerd Font, monospace";

  for (let i = 0; i < drops.length; i++) {
    const text = chars[Math.floor(Math.random() * chars.length)];
    ctx.fillStyle = Math.random() > 0.92 ? "#ff0055" : "#00f0ff";
    ctx.fillText(text, i * fontSize, drops[i] * fontSize);

    if (drops[i] * fontSize > h && Math.random() > 0.975) {
      drops[i] = 0;
    }
    drops[i]++;
  }
}, 40);

let pendingPassword = "";
let isAuthenticating = false;

function initGreeter() {
  const userSelect = document.getElementById("user-select");
  const sessionSelect = document.getElementById("session-select");
  const passwordInput = document.getElementById("password-input");
  const statusMsg = document.getElementById("status-msg");
  const panel = document.getElementById("hud-panel");

  if (lightdm.users && lightdm.users.length > 0) {
    lightdm.users.forEach((u) => {
      const opt = document.createElement("option");
      opt.value = u.username;
      opt.textContent = u.display_name || u.username;
      userSelect.appendChild(opt);
    });
  }

  if (lightdm.sessions && lightdm.sessions.length > 0) {
    lightdm.sessions.forEach((s) => {
      const opt = document.createElement("option");
      opt.value = s.key;
      opt.textContent = s.name;
      if (s.key === "i3" || s.key === lightdm.default_session) {
        opt.selected = true;
      }
      sessionSelect.appendChild(opt);
    });
  }

  lightdm.show_prompt.connect(() => {
    if (isAuthenticating) {
      lightdm.respond(pendingPassword);
    }
  });

  lightdm.show_message.connect((text) => {
    statusMsg.textContent = text;
  });

  lightdm.authentication_complete.connect(() => {
    isAuthenticating = false;
    pendingPassword = "";
    if (lightdm.is_authenticated) {
      statusMsg.textContent = "ACCESO CONCEDIDO // CARGANDO ENTORNO...";
      statusMsg.className = "status ok";
      const session = sessionSelect.value || lightdm.default_session || "i3";
      lightdm.start_session(session);
    } else {
      statusMsg.textContent = "ACCESO DENEGADO // CLAVE INCORRECTA";
      statusMsg.className = "status err";
      panel.classList.remove("shake");
      void panel.offsetWidth;
      panel.classList.add("shake");
      passwordInput.value = "";
      passwordInput.disabled = false;
      passwordInput.focus();
    }
  });

  document.getElementById("login-form").addEventListener("submit", (e) => {
    e.preventDefault();
    if (isAuthenticating) return;
    pendingPassword = passwordInput.value;
    isAuthenticating = true;
    passwordInput.disabled = true;
    statusMsg.textContent = "VERIFICANDO IDENTIDAD...";
    statusMsg.className = "status";

    if (lightdm.in_authentication) {
      lightdm.cancel_authentication();
    }
    lightdm.authenticate(userSelect.value);
  });

  document.getElementById("btn-reboot").addEventListener("click", () => {
    if (lightdm.can_restart) lightdm.restart();
  });

  document.getElementById("btn-shutdown").addEventListener("click", () => {
    if (lightdm.can_shutdown) lightdm.shutdown();
  });
}

if (window.lightdm && Array.isArray(window.lightdm.users) && window.lightdm.users.length > 0) {
  initGreeter();
} else {
  window.addEventListener("GreeterReady", initGreeter);
}
