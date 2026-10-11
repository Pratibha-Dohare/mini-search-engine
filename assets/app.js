const form = document.querySelector('#searchForm');
const input = document.querySelector('#query');
const results = document.querySelector('#results');
const list = document.querySelector('#resultList');
const summary = document.querySelector('#summary');
const intro = document.querySelector('#intro');
let controller;
let timer;

function showMessage(message, cssClass = 'empty') {
  list.replaceChildren();
  const p = document.createElement('p'); p.className = cssClass; p.textContent = message; list.append(p);
}
function render(items) {
  list.replaceChildren();
  if (!items.length) return showMessage('No matches found. Try another keyword.');
  for (const item of items) {
    const article = document.createElement('article'); article.className = 'result';
    const url = document.createElement('small'); url.textContent = item.url;
    const link = document.createElement('a'); link.href = item.url; link.textContent = item.title;
    link.target = '_blank'; link.rel = 'noopener noreferrer';
    const desc = document.createElement('p'); desc.textContent = item.description;
    const tag = document.createElement('span'); tag.className = 'tag'; tag.textContent = item.category;
    article.append(url, link, desc, tag); list.append(article);
  }
}
async function search(term) {
  const q = term.trim();
  history.replaceState(null, '', q ? '?q=' + encodeURIComponent(q) : location.pathname);
  if (controller) controller.abort();
  if (!q) { results.hidden = true; intro.hidden = false; return; }
  controller = new AbortController();
  results.hidden = false; intro.hidden = true; summary.textContent = 'Searching…';
  try {
    const response = await fetch('search.php?q=' + encodeURIComponent(q), {signal: controller.signal});
    if (!response.ok) throw new Error('Search unavailable');
    const data = await response.json();
    summary.textContent = `${data.count} results for “${q}”`;
    render(data.results);
  } catch (error) {
    if (error.name !== 'AbortError') { summary.textContent = 'Something went wrong'; showMessage('Could not connect to the search database. Check your PHP/MySQL setup.', 'empty error'); }
  }
}
form.addEventListener('submit', event => {event.preventDefault(); clearTimeout(timer); search(input.value);});
input.addEventListener('input', () => {clearTimeout(timer); timer = setTimeout(() => search(input.value), 350);});
document.querySelectorAll('[data-query]').forEach(button => button.addEventListener('click', () => {input.value = button.dataset.query; search(input.value);}));
document.addEventListener('keydown', event => {if (event.key === '/' && document.activeElement !== input) {event.preventDefault(); input.focus();}});
const initial = new URLSearchParams(location.search).get('q');
if (initial) {input.value = initial; search(initial);}
