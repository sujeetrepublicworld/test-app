const colors = ['#ff4d4d', '#ffd93d', '#6bcf63', '#4d96ff', '#ff6ec7'];

function createBalloon() {
  const b = document.createElement('div');
  b.className = 'balloon';
  b.style.left = Math.random() * 100 + 'vw';
  b.style.background = colors[Math.floor(Math.random() * colors.length)];
  b.style.animationDuration = 4 + Math.random() * 4 + 's';

  document.body.appendChild(b);

  setTimeout(() => b.remove(), 8000);
}

setInterval(createBalloon, 600);
